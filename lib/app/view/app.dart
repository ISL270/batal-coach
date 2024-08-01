import 'package:btl/counter/counter.dart';
import 'package:btl/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          locale: arabicLocale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const CounterPage(),
        );
      },
    );
  }
}
