import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:max_flutter_authentication/firebase_options.dart';
import 'package:max_flutter_authentication/repositories/auth_repository.dart';

import 'bloc/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/bloc_observer.dart';
import 'config/routes.dart';

Future<void> main() async {
  BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    final AuthRepository authRepository = AuthRepository();
    runApp(MyApp(authRepository: authRepository));
  }, blocObserver: AppBlocObserver());
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository;
  const MyApp({Key? key, required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (_) => AppBloc(authRepository: _authRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FlowBuilder(
            state: context.select((AppBloc bloc) => bloc.state.status), onGeneratePages: onGenerateAppViewPages));
  }
}
