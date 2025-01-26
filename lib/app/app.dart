import 'package:btl/app/core/extension_methods/getit_x.dart';
import 'package:btl/app/core/injection/injection.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/models/status.dart';
import 'package:btl/app/core/routing/coach_router.dart';
import 'package:btl/app/core/routing/trainee_router.dart';
import 'package:btl/app/core/theming/app_theme.dart';
import 'package:btl/app/features/authentication/domain/models/auth_state.dart';
import 'package:btl/app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:btl/app/features/settings/domain/settings_repository.dart';
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
            BlocProvider(create: (_) => SettingsBloc(getIt.get<SettingsRepository>())),
            BlocProvider(create: (_) => getIt.authBloc),
          ],
          child: BlocBuilder<AuthBloc, Status<AuthState>>(
            buildWhen: hasUserTypeChanged,
            builder: (context, authState) {
              return BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, settingsState) {
                  return MaterialApp.router(
                    theme: AppTheme.light,
                    darkTheme: AppTheme.dark,
                    themeMode: settingsState.settings.themeMode,
                    locale: settingsState.settings.language.locale,
                    supportedLocales: AppLocalizations.supportedLocales,
                    localizationsDelegates: AppLocalizations.localizationsDelegates,
                    debugShowCheckedModeBanner: appFlavor != Flavors.production.name,
                    routerConfig: (authState.user?.isCoach ?? true) ? coachRouter : traineeRouter,
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
