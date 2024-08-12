import 'package:authentication_repository/authentication_repository.dart';
import 'package:btl/app/bloc/auth_bloc.dart';
import 'package:btl/app/cubit/theme_cubit.dart';
import 'package:btl/app/flavors.dart';
import 'package:btl/app/routes.dart';
import 'package:btl/app/themes.dart';
import 'package:btl/l10n/l10n.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  final AuthenticationRepository _authRepo;

  const App({required AuthenticationRepository authRepo, super.key}) : _authRepo = authRepo;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) {
        return RepositoryProvider.value(
          value: _authRepo,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => ThemeCubit()),
              BlocProvider(create: (_) => AuthBloc(authRepo: _authRepo)),
            ],
            child: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return MaterialApp(
                  locale: arabicLocale,
                  themeMode: themeMode,
                  theme: AppTheme.light,
                  darkTheme: AppTheme.dark,
                  supportedLocales: AppLocalizations.supportedLocales,
                  localizationsDelegates: AppLocalizations.localizationsDelegates,
                  debugShowCheckedModeBanner: appFlavor != Flavors.production.name,
                  home: FlowBuilder<AuthStatus>(
                    state: context.select((AuthBloc bloc) => bloc.state.status),
                    onGeneratePages: onGenerateAppViewPages,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
