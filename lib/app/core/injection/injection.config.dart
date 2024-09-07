// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:btl/app/coach/exercise/data/data_sources/exercise_algolia_data_source.dart'
    as _i839;
import 'package:btl/app/coach/exercise/data/data_sources/exercise_remote_data_source.dart'
    as _i510;
import 'package:btl/app/coach/exercise/data/repositories/exercise_repository.dart'
    as _i836;
import 'package:btl/app/coach/exercise/presentation/bloc/exercise_bloc.dart'
    as _i511;
import 'package:btl/app/core/injection/firebase_module.dart' as _i260;
import 'package:btl/app/core/local_db/i_local_db.dart' as _i634;
import 'package:btl/app/core/local_db/isar_db.dart' as _i793;
import 'package:btl/app/features/authentication/data/data_sources/local/user_isar_source.dart'
    as _i193;
import 'package:btl/app/features/authentication/data/data_sources/local/user_local_source.dart'
    as _i623;
import 'package:btl/app/features/authentication/data/data_sources/remote/user_firestore_source.dart'
    as _i538;
import 'package:btl/app/features/authentication/data/data_sources/remote/user_remote_source.dart'
    as _i139;
import 'package:btl/app/features/authentication/domain/repositories/auth_repository.dart'
    as _i902;
import 'package:btl/app/features/authentication/domain/repositories/user_repository.dart'
    as _i55;
import 'package:btl/app/features/authentication/presentation/bloc/auth_bloc.dart'
    as _i260;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
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
    final firebaseModule = _$FirebaseModule();
    gh.singleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.singleton<_i59.FirebaseAuth>(() => firebaseModule.auth);
    gh.singleton<_i116.GoogleSignIn>(() => firebaseModule.googleSignIn);
    await gh.singletonAsync<_i634.LocalDB>(
      () => _i793.IsarDB.create(),
      preResolve: true,
    );
    gh.singleton<_i510.ExerciseRemoteDataSource>(
        () => _i839.ExerciseAlgoliaDataSource());
    gh.singleton<_i836.ExerciseRepository>(
        () => _i836.ExerciseRepository(gh<_i510.ExerciseRemoteDataSource>()));
    gh.singleton<_i623.UserLocalSource>(
        () => _i193.UserIsarSource(gh<_i634.LocalDB>()));
    gh.singleton<_i139.UserRemoteSource>(
        () => _i538.UserFirestoreSource(gh<_i974.FirebaseFirestore>()));
    gh.singleton<_i55.UserRepository>(() => _i55.UserRepository(
          gh<_i623.UserLocalSource>(),
          gh<_i139.UserRemoteSource>(),
        ));
    gh.factory<_i511.ExerciseBloc>(
        () => _i511.ExerciseBloc(gh<_i836.ExerciseRepository>()));
    await gh.singletonAsync<_i902.AuthRepository>(
      () {
        final i = _i902.AuthRepository(
          gh<_i59.FirebaseAuth>(),
          gh<_i116.GoogleSignIn>(),
          gh<_i55.UserRepository>(),
        );
        return i.init().then((_) => i);
      },
      preResolve: true,
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i260.AuthBloc>(
        () => _i260.AuthBloc(gh<_i902.AuthRepository>()));
    return this;
  }
}

class _$FirebaseModule extends _i260.FirebaseModule {}
