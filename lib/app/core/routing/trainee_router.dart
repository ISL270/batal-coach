import 'package:btl/app/core/extensions/getit_x.dart';
import 'package:btl/app/core/injection/injection.dart';
import 'package:btl/app/core/routing/go_router_refresh_stream.dart';
import 'package:btl/app/core/routing/go_router_state_extension.dart';
import 'package:btl/app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:btl/app/features/login/cubit/login_cubit.dart';
import 'package:btl/app/features/login/login_screen.dart';
import 'package:btl/app/features/sign_up/presentation/sign_up_screen.dart';
import 'package:btl/app/features/splash/bloc/splash_bloc.dart';
import 'package:btl/app/features/splash/splash_screen.dart';
import 'package:btl/app/trainee/features/home/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final traineeRouter = GoRouter(
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
        builder: (context, state) => BlocProvider(
              create: (_) => LoginCubit(getIt.authRepo),
              child: const LoginScreen(),
            ),
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
  refreshListenable: GoRouterRefreshStream(getIt.authBloc.stream.where(
    (success) => success.status.isSuccess,
  )),
  redirect: (context, state) {
    // If the user is not logged in, they need to login.
    // Bundle the location the user is coming from into a query parameter
    final fromloc = state.isGoingToHome ? '' : state.matchedLocation;
    if (!getIt.authBloc.state.isAuthenticated) {
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
