import 'package:authentication_repository/authentication_repository.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AuthModule {
  @singleton
  @preResolve
  Future<AuthenticationRepository> get authRepo async {
    final authenticationRepository = AuthenticationRepository();
    await authenticationRepository.user.first;
    return authenticationRepository;
  }
}
