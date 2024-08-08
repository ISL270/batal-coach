import 'package:btl/app/bloc/auth_bloc.dart';
import 'package:btl/features/home/view/home_page.dart';
import 'package:btl/features/login/view/login_page.dart';
import 'package:flutter/widgets.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AuthStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AuthStatus.authenticated:
      return [HomePage.page()];
    case AuthStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
