import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:max_flutter_authentication/repositories/auth_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static Page page() => const MaterialPage<void>(child: HomeScreen());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<AuthRepository>().logOut();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: const Center(
          child: Text('Home Screen'),
        ));
  }
}
