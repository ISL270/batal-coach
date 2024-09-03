import 'package:btl/app/core/extensions/getit_x.dart';
import 'package:btl/app/core/injection/injection.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/routing/coach_router.dart';
import 'package:btl/app/core/routing/trainee_router.dart';
import 'package:btl/app/core/theming/app_theme.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:btl/app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:btl/app/features/settings/settings/settings_bloc.dart';
import 'package:btl/flavors/flavors.dart';
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
            BlocProvider(create: (_) => getIt.authBloc),
          ],
          child: BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) => previous.user?.userType != current.user?.userType,
            builder: (context, authState) {
              return BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, settingsState) {
                  return MaterialApp.router(
                    theme: AppTheme.light,
                    darkTheme: AppTheme.dark,
                    themeMode: settingsState.themeMode,
                    locale: settingsState.language.locale,
                    supportedLocales: AppLocalizations.supportedLocales,
                    localizationsDelegates: AppLocalizations.localizationsDelegates,
                    debugShowCheckedModeBanner: appFlavor != Flavors.production.name,
                    routerConfig:
                        (authState.user?.userType.isCoach ?? true) ? coachRouter : traineeRouter,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
