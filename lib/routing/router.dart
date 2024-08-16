import 'package:authentication_repository/authentication_repository.dart';
import 'package:btl/features/home/home_screen.dart';
import 'package:btl/features/login/login_screen.dart';
import 'package:btl/features/sign_up/sign_up_screen.dart';
import 'package:btl/features/splash/bloc/splash_bloc.dart';
import 'package:btl/features/splash/splash_screen.dart';
import 'package:btl/injection/injection.dart';
import 'package:btl/routing/go_router_refresh_stream.dart';
import 'package:btl/routing/go_router_state_extension.dart';
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

    // bundle the location the user is coming from into a query parameter
    final fromloc = state.isGoingToHome ? '' : state.matchedLocation;
    if (!authenticated) {
      return state.isGoingToSplash || state.isLoggingIn || state.isSigningUp
          ? null
          : state.namedLocation(
              LoginScreen.name,
              queryParameters: {if (fromloc.isNotEmpty) 'from': fromloc},
            );
    }

    // if the user is logged in, send them where they were going before (or
    // home if they weren't going anywhere)
    if (state.isLoggingIn) {
      return state.uri.queryParameters['from'] ?? state.namedLocation(HomeScreen.name);
    }

    // no need to redirect at all
    return null;
  },

  //TODO: create an error screen.
  // errorBuilder: (context, state) {},
);
