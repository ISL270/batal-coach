import 'package:btl/app/cubit/theme_cubit.dart';
import 'package:btl/app/themes.dart';
import 'package:btl/counter/counter.dart';
import 'package:btl/l10n/l10n.dart';
import 'package:flutter/material.dart';
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
            BlocProvider(create: (_) => ThemeCubit()),
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
                home: const CounterPage(),
              );
            },
          ),
        );
      },
    );
  }
}
