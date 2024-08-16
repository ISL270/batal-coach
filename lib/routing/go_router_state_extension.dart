import 'package:btl/features/home/home_screen.dart';
import 'package:btl/features/login/login_screen.dart';
import 'package:btl/features/sign_up/sign_up_screen.dart';
import 'package:btl/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

extension GoRouterStateX on GoRouterState {
  bool get isLoggingIn => matchedLocation == namedLocation(LoginScreen.name);
  bool get isSigningUp => matchedLocation == namedLocation(SignUpScreen.name);
  bool get isGoingToSplash => matchedLocation == namedLocation(SplashScreen.name);
  bool get isGoingToHome => matchedLocation == namedLocation(HomeScreen.name);
}
