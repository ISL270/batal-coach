import 'package:authentication_repository/authentication_repository.dart';
import 'package:btl/app/bloc/auth/auth_bloc.dart';
import 'package:btl/app/theming/text_theme_extension.dart';
import 'package:btl/features/dashboard/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: BlocSelector<AuthBloc, AuthState, User>(
          selector: (state) => state.user,
          builder: (context, user) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Avatar(photo: user.photo),
                const SizedBox(height: 4),
                Text(
                  user.email ?? '',
                  style: context.textThemeX.large,
                ),
                const SizedBox(height: 4),
                Text(
                  user.name ?? '',
                  style: context.textThemeX.large,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
