import 'package:authentication_repository/authentication_repository.dart';
import 'package:btl/features/home/home_screen.dart';
import 'package:btl/features/login/login_screen.dart';
import 'package:btl/features/sign_up/sign_up_screen.dart';
import 'package:btl/features/splash/bloc/splash_bloc.dart';
import 'package:btl/features/splash/splash_screen.dart';
import 'package:btl/injection/injection.dart';
import 'package:btl/routing/go_router_refresh_stream.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: SplashScreen.name,
      builder: (context, state) => BlocProvider(
        create: (context) => SplashBloc(),
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
        name: LoginScreen.name,
        path: '/${LoginScreen.name}',
        builder: (context, state) => const LoginScreen(),
        routes: [
          GoRoute(
            name: SignUpScreen.name,
            path: SignUpScreen.name,
            builder: (context, state) => const SignUpScreen(),
          ),
        ]),
    GoRoute(
      name: HomeScreen.name,
      path: '/${HomeScreen.name}',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
  refreshListenable: GoRouterRefreshStream(getIt.get<AuthenticationRepository>().user),
  redirect: (context, state) {
    // if the user is not logged in, they need to login
    final authenticated = getIt.get<AuthenticationRepository>().isAuthenticated;

    final loginloc = state.namedLocation(LoginScreen.name);
    final loggingIn = state.matchedLocation == loginloc;

    final signUpLoc = state.namedLocation(SignUpScreen.name);
    final signnigUp = state.matchedLocation == signUpLoc;

    // bundle the location the user is coming from into a query parameter
    final homeloc = state.namedLocation(HomeScreen.name);
    final fromloc = state.matchedLocation == homeloc ? '' : state.matchedLocation;
    if (!authenticated) {
      return loggingIn || signnigUp
          ? null
          : state.namedLocation(
              LoginScreen.name,
              queryParameters: {if (fromloc.isNotEmpty) 'from': fromloc},
            );
    }

    // if the user is logged in, send them where they were going before (or
    // home if they weren't going anywhere)
    if (loggingIn) return state.uri.queryParameters['from'] ?? homeloc;

    // no need to redirect at all
    return null;
  },

  //TODO: create an error screen.
  // errorBuilder: (context, state) {},
);
