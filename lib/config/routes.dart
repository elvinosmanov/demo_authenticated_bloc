import 'package:flutter/material.dart';
import 'package:max_flutter_authentication/bloc/app_bloc.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';

List<Page> onGenerateAppViewPages(
  AppStatus status,
  List<Page<dynamic>> pages
 ) {
  switch (status) {
    case AppStatus.authenticated:
      return [HomeScreen.page()];
    case AppStatus.unathenticated:
      return [LoginScreen.page()];
  }
}
