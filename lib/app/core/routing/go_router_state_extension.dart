import 'package:btl/app/core/extensions/getit_x.dart';
import 'package:btl/app/core/injection/injection.dart';
import 'package:btl/app/features/authentication/presentation/bloc/auth_bloc_extension.dart';
import 'package:btl/app/features/login/login_screen.dart';
import 'package:btl/app/features/settings/settings_screen.dart';
import 'package:btl/app/features/sign_up/presentation/sign_up_screen.dart';
import 'package:btl/app/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

extension GoRouterStateX on GoRouterState {
  bool get isLoggingIn => matchedLocation == namedLocation(LoginScreen.name);
  bool get isSigningUp => matchedLocation == namedLocation(SignUpScreen.name);
  bool get isLoggingOut => matchedLocation == namedLocation(SettingsScreen.name);
  bool get isGoingToSplash => matchedLocation == namedLocation(SplashScreen.name);
  bool get isGoingToHome => matchedLocation == namedLocation(getIt.authBloc.homeNamedRoute);
}
