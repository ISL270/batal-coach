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
import 'package:btl/app/features/authentication/presentation/bloc/auth_bloc.dart' as _i1067;
import 'package:btl/app/core/injection/firebase_module.dart' as _i260;
import 'package:btl/app/features/authentication/domain/repositories/auth_repository.dart'
    as _i902;
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
    gh.singleton<_i510.ExerciseRemoteDataSource>(
        () => _i839.ExerciseAlgoliaDataSource());
    await gh.singletonAsync<_i902.AuthRepository>(
      () {
        final i = _i902.AuthRepository(
          gh<_i974.FirebaseFirestore>(),
          gh<_i59.FirebaseAuth>(),
          gh<_i116.GoogleSignIn>(),
        );
        return i.init().then((_) => i);
      },
      preResolve: true,
    );
    gh.singleton<_i1067.AuthBloc>(
        () => _i1067.AuthBloc(gh<_i902.AuthRepository>()));
    gh.singleton<_i836.ExerciseRepository>(
        () => _i836.ExerciseRepository(gh<_i510.ExerciseRemoteDataSource>()));
    gh.factory<_i511.ExerciseBloc>(
        () => _i511.ExerciseBloc(gh<_i836.ExerciseRepository>()));
    return this;
  }
}

class _$FirebaseModule extends _i260.FirebaseModule {}
