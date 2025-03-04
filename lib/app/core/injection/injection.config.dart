// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:btl/app/coach/features/clients/data/sources/local/clients_isar_source.dart'
    as _i347;
import 'package:btl/app/coach/features/clients/data/sources/remote/clients_firestore_source.dart'
    as _i886;
import 'package:btl/app/coach/features/clients/domain/clients_repository.dart'
    as _i999;
import 'package:btl/app/coach/features/clients/presentation/bloc/clients_bloc.dart'
    as _i441;
import 'package:btl/app/coach/features/clients/sub_features/add_client/presentation/cubit/add_client_cubit.dart'
    as _i1031;
import 'package:btl/app/coach/features/exercises/data/data_sources/local/exercises_isar_source.dart'
    as _i714;
import 'package:btl/app/coach/features/exercises/data/data_sources/remote/exercises_firestore_source.dart'
    as _i577;
import 'package:btl/app/coach/features/exercises/domain/repositories/exercises_repository.dart'
    as _i611;
import 'package:btl/app/coach/features/exercises/presentation/bloc/exercises_bloc.dart'
    as _i450;
import 'package:btl/app/coach/features/workouts/data/sources/local/workout_isar_source.dart'
    as _i25;
import 'package:btl/app/coach/features/workouts/data/sources/remote/workout_firestore_source.dart'
    as _i389;
import 'package:btl/app/coach/features/workouts/domain/workout_repository.dart'
    as _i820;
import 'package:btl/app/core/firestore/firestore_service.dart' as _i997;
import 'package:btl/app/core/injection/auth_module.dart' as _i399;
import 'package:btl/app/core/isar/isar_service.dart' as _i26;
import 'package:btl/app/core/l10n/l10n_service.dart' as _i222;
import 'package:btl/app/features/authentication/data/sources/local/user_isar_source.dart'
    as _i120;
import 'package:btl/app/features/authentication/data/sources/remote/user_firestore_source.dart'
    as _i308;
import 'package:btl/app/features/authentication/domain/repositories/auth_repository.dart'
    as _i902;
import 'package:btl/app/features/authentication/domain/repositories/user_repository.dart'
    as _i55;
import 'package:btl/app/features/authentication/presentation/bloc/auth_bloc.dart'
    as _i260;
import 'package:btl/app/features/settings/data/sources/local/settings_isar_source.dart'
    as _i557;
import 'package:btl/app/features/settings/domain/settings_repository.dart'
    as _i662;
import 'package:btl/app/features/settings/settings/settings_bloc.dart'
    as _i1055;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final authModule = _$AuthModule();
    await gh.singletonAsync<_i26.IsarService>(
      () => _i26.IsarService.create(),
      preResolve: true,
    );
    gh.singleton<_i222.L10nService>(() => _i222.L10nService());
    gh.singleton<_i997.FirestoreService>(() => _i997.FirestoreService());
    gh.singleton<_i59.FirebaseAuth>(() => authModule.auth);
    gh.singleton<_i116.GoogleSignIn>(() => authModule.googleSignIn);
    gh.singleton<_i308.UserFirestoreSource>(
        () => _i308.UserFirestoreSource(gh<_i997.FirestoreService>()));
    gh.singleton<_i557.SettingsIsarSource>(
        () => _i557.SettingsIsarSource(gh<_i26.IsarService>()));
    gh.singleton<_i120.UserIsarSource>(
        () => _i120.UserIsarSource(gh<_i26.IsarService>()));
    gh.singleton<_i347.ClientsIsarSource>(
        () => _i347.ClientsIsarSource(gh<_i26.IsarService>()));
    gh.singleton<_i25.WorkoutIsarSource>(
        () => _i25.WorkoutIsarSource(gh<_i26.IsarService>()));
    gh.singleton<_i714.ExercisesIsarSource>(
        () => _i714.ExercisesIsarSource(gh<_i26.IsarService>()));
    gh.singleton<_i55.UserRepository>(() => _i55.UserRepository(
          gh<_i120.UserIsarSource>(),
          gh<_i308.UserFirestoreSource>(),
        ));
    gh.singleton<_i662.SettingsRepository>(
        () => _i662.SettingsRepository(gh<_i557.SettingsIsarSource>()));
    gh.singleton<_i902.AuthRepository>(
      () => _i902.AuthRepository(
        gh<_i59.FirebaseAuth>(),
        gh<_i116.GoogleSignIn>(),
        gh<_i55.UserRepository>(),
      ),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i886.ClientsFirestoreSource>(
      () => _i886.ClientsFirestoreSource(gh<_i997.FirestoreService>()),
      dispose: (i) => i.dispMethod(),
    );
    gh.singleton<_i389.WorkoutFirestoreSource>(
        () => _i389.WorkoutFirestoreSource(gh<_i997.FirestoreService>()));
    gh.singleton<_i577.ExercisesFirestoreSource>(
      () => _i577.ExercisesFirestoreSource(gh<_i997.FirestoreService>()),
      dispose: (i) => i.dispMethod(),
    );
    gh.singleton<_i260.AuthBloc>(
        () => _i260.AuthBloc(gh<_i902.AuthRepository>()));
    gh.singleton<_i611.ExercisesRepository>(
      () => _i611.ExercisesRepository(
        gh<_i902.AuthRepository>(),
        gh<_i577.ExercisesFirestoreSource>(),
        gh<_i714.ExercisesIsarSource>(),
      ),
      dispose: (i) => i.dispMethod(),
    );
    gh.singleton<_i999.ClientsRepository>(
      () => _i999.ClientsRepository(
        gh<_i902.AuthRepository>(),
        gh<_i886.ClientsFirestoreSource>(),
        gh<_i347.ClientsIsarSource>(),
      ),
      dispose: (i) => i.dispMethod(),
    );
    gh.factory<_i1031.AddClientCubit>(
        () => _i1031.AddClientCubit(gh<_i999.ClientsRepository>()));
    gh.factory<_i441.ClientsBloc>(
        () => _i441.ClientsBloc(gh<_i999.ClientsRepository>()));
    gh.factory<_i1055.SettingsBloc>(
        () => _i1055.SettingsBloc(gh<_i662.SettingsRepository>()));
    gh.factory<_i450.ExercisesBloc>(
        () => _i450.ExercisesBloc(gh<_i611.ExercisesRepository>()));
    gh.singleton<_i820.WorkoutRepository>(
      () => _i820.WorkoutRepository(
        gh<_i902.AuthRepository>(),
        gh<_i389.WorkoutFirestoreSource>(),
        gh<_i25.WorkoutIsarSource>(),
        gh<_i611.ExercisesRepository>(),
      ),
      dispose: (i) => i.dispMethod(),
    );
    return this;
  }
}

class _$AuthModule extends _i399.AuthModule {}
