import 'package:authentication_repository/authentication_repository.dart';
import 'package:btl/core/blocs/auth/auth_bloc.dart';
import 'package:btl/core/injection/injection.dart';
import 'package:btl/core/routing/router.dart';
import 'package:btl/core/theming/app_theme.dart';
import 'package:btl/features/settings/settings/settings_bloc.dart';
import 'package:btl/flavors/flavors.dart';
import 'package:btl/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => SettingsBloc()),
            BlocProvider(create: (_) => AuthBloc(authRepo: getIt.get<AuthenticationRepository>())),
          ],
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              return MaterialApp.router(
                routerConfig: router,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: state.themeMode,
                locale: state.language.locale,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                debugShowCheckedModeBanner: appFlavor != Flavors.production.name,
              );
            },
          ),
        );
      },
    );
  }
}
