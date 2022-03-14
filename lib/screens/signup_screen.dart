import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpScreen());
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text('Home Screen'),
    ));
  }
}
