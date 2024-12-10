import 'package:btl/app/coach/features/clients/domain/repositories/clients_repository.dart';
import 'package:btl/app/coach/features/clients/presentation/bloc/clients_bloc.dart';
import 'package:btl/app/coach/features/clients/presentation/clients_screen.dart';
import 'package:btl/app/coach/features/exercise_builder/presentation/exercise_builder.dart';
import 'package:btl/app/coach/features/exercises/domain/repositories/exercises_repository.dart';
import 'package:btl/app/coach/features/exercises/presentation/bloc/exercises_bloc.dart';
import 'package:btl/app/coach/features/exercises/presentation/exercises_screen.dart';
import 'package:btl/app/coach/features/home/home_screen.dart';
import 'package:btl/app/coach/features/workout_builder.dart/presentation/cubit/workout_builder_cubit.dart';
import 'package:btl/app/coach/features/workout_builder.dart/presentation/workout_builder_screen.dart';
import 'package:btl/app/coach/features/workouts/domain/workout_repository.dart';
import 'package:btl/app/coach/features/workouts/presentation/bloc/workouts_bloc.dart';
import 'package:btl/app/coach/features/workouts/presentation/workouts_screen.dart';
import 'package:btl/app/core/extension_methods/getit_x.dart';
import 'package:btl/app/core/injection/injection.dart';
import 'package:btl/app/core/routing/go_router_refresh_stream.dart';
import 'package:btl/app/core/routing/go_router_state_extension.dart';
import 'package:btl/app/features/about_app/presentation/about_app_screen.dart';
import 'package:btl/app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:btl/app/features/authentication/presentation/bloc/auth_bloc_extension.dart';
import 'package:btl/app/features/edit_profile/presentation/edit_profile_screen.dart';
import 'package:btl/app/features/login/cubit/login_cubit.dart';
import 'package:btl/app/features/login/login_screen.dart';
import 'package:btl/app/features/settings/settings_screen.dart';
import 'package:btl/app/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:btl/app/features/sign_up/presentation/sign_up_screen.dart';
import 'package:btl/app/features/splash/bloc/splash_bloc.dart';
import 'package:btl/app/features/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final coachRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
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
            builder: (context, state) => BlocProvider(
              create: (_) => SignUpCubit(getIt.authRepo),
              child: const SignUpScreen(),
            ),
          ),
        ]),
    StatefulShellRoute.indexedStack(
      builder: (_, ___, navigationShell) => HomeScreen(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          navigatorKey: _exerecisesNavigatorKey,
          routes: [
            GoRoute(
              name: ExercisesScreen.name,
              path: '/${ExercisesScreen.name}',
              pageBuilder: (context, state) => NoTransitionPage(
                child: BlocProvider(
                  create: (context) => ExercisesBloc(getIt.get<ExercisesRepository>()),
                  child: const ExercisesScreen(),
                ),
              ),
              routes: [
                GoRoute(
                  name: ExerciseBuilderScreen.name,
                  path: ExerciseBuilderScreen.name,
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const ExerciseBuilderScreen(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _workoutsNavigatorKey,
          routes: [
            GoRoute(
                name: WorkoutsScreen.name,
                path: '/${WorkoutsScreen.name}',
                pageBuilder: (context, state) => NoTransitionPage(
                      child: BlocProvider(
                        create: (context) => WorkoutsBloc(getIt.get<WorkoutRepository>()),
                        child: const WorkoutsScreen(),
                      ),
                    ),
                routes: [
                  GoRoute(
                    name: WorkoutBuilderScreen.name,
                    path: WorkoutBuilderScreen.name,
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) => CupertinoPage(
                      fullscreenDialog: true,
                      child: BlocProvider(
                        create: (context) => WorkoutBuilderCubit(getIt.get<WorkoutRepository>()),
                        child: const WorkoutBuilderScreen(),
                      ),
                    ),
                  ),
                ]),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _clientsNavigatorKey,
          routes: [
            GoRoute(
              name: ClientsScreen.name,
              path: '/${ClientsScreen.name}',
              pageBuilder: (context, state) => NoTransitionPage(
                child: BlocProvider(
                  create: (context) => ClientsBloc(getIt.get<ClientsRepository>()),
                  child: const ClientsScreen(),
                ),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _settingsNavigatorKey,
          routes: [
            GoRoute(
              name: SettingsScreen.name,
              path: '/${SettingsScreen.name}',
              pageBuilder: (context, state) => const NoTransitionPage(child: SettingsScreen()),
              routes: [
                GoRoute(
                  name: EditProfileScreen.name,
                  path: EditProfileScreen.name,
                  parentNavigatorKey: _rootNavigatorKey,
                  pageBuilder: (context, state) =>
                      const NoTransitionPage(child: EditProfileScreen()),
                ),
                GoRoute(
                  name: AboutAppScreen.name,
                  path: AboutAppScreen.name,
                  parentNavigatorKey: _rootNavigatorKey,
                  pageBuilder: (context, state) => const NoTransitionPage(child: AboutAppScreen()),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
  refreshListenable: GoRouterRefreshStream(
    getIt.authBloc.stream.where((state) => state.isSuccess),
  ),
  redirect: (context, state) {
    // If the user is not logged in, they need to login.
    // Bundle the location the user is coming from into a query parameter
    final fromloc = (state.isGoingToHome || state.isLoggingOut) ? '' : state.matchedLocation;
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
      return state.uri.queryParameters['from'] ??
          state.namedLocation(getIt.authBloc.homeNamedRoute);
    }

    // no need to redirect at all
    return null;
  },
  //TODO: create an error screen.
  // errorBuilder: (context, state) {},
);

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _exerecisesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: ExercisesScreen.name);
final _workoutsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: WorkoutsScreen.name);
final _clientsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: ClientsScreen.name);
final _settingsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: SettingsScreen.name);
