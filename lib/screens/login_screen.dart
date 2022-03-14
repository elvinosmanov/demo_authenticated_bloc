import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:max_flutter_authentication/core/extensions/padding_extension.dart';
import 'package:max_flutter_authentication/cubit/login/login_cubit.dart';
import 'package:max_flutter_authentication/repositories/auth_repository.dart';
import 'package:max_flutter_authentication/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static Page page() => const MaterialPage<void>(child: LoginScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => LoginCubit(
        context.read<AuthRepository>(),
      ),
      child: const LoginForm(),
    ));
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.error) {
          
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
               SnackBar(
                content: Text(state.errorMessage),
              ),
            );
        }
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _EmailInput(),
            SizedBox(height: 4),
            _PasswordInput(),
            SizedBox(height: 4),
            _LoginButton(),
            SizedBox(height: 4),
            _SignUpButton()
          ],
        ).padding(),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Password..'),
          onChanged: (password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      // buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Email..'),
          onChanged: (email) {
            context.read<LoginCubit>().emailChanged(email);
          },
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return state.status == LoginStatus.submitting
            ? const CircularProgressIndicator()
            : ElevatedButton.icon(
                onPressed: () {
                  context.read<LoginCubit>().loginWithCredentials();
                },
                icon: const Icon(Icons.login),
                label: const Text('Login'));
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return ElevatedButton.icon(
            onPressed: () {
              Navigator.push(context, SignUpScreen.route());
            },
            icon: const Icon(Icons.app_registration_rounded),
            label: const Text('SignUp'));
      },
    );
  }
}
