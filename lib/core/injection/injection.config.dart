// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:authentication_repository/authentication_repository.dart'
    as _i223;
import 'package:btl/features/authentication/auth_module.dart' as _i732;
import 'package:btl/features/exercise/data/data_sources/exercise_algolia_data_source.dart'
    as _i1068;
import 'package:btl/features/exercise/data/data_sources/exercise_remote_data_source.dart'
    as _i556;
import 'package:btl/features/exercise/data/repositories/exercise_repository.dart'
    as _i418;
import 'package:get_it/get_it.dart' as _i174;
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
    await gh.singletonAsync<_i223.AuthenticationRepository>(
      () => authModule.authRepo,
      preResolve: true,
    );
    gh.singleton<_i556.ExerciseRemoteDataSource>(
        () => _i1068.ExerciseAlgoliaDataSource());
    gh.singleton<_i418.ExerciseRepository>(
        () => _i418.ExerciseRepository(gh<_i556.ExerciseRemoteDataSource>()));
    return this;
  }
}

class _$AuthModule extends _i732.AuthModule {}
