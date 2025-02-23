import 'package:btl/app/core/models/domain/generic_exception.dart';
import 'package:btl/app/features/authentication/data/sources/local/user_isar_source.dart';
import 'package:btl/app/features/authentication/data/sources/remote/user_firestore_source.dart';
import 'package:btl/app/features/authentication/domain/models/coach_type.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@singleton
final class UserRepository {
  final UserIsarSource _localSource;
  final UserFirestoreSource _remoteSource;

  UserRepository(this._localSource, this._remoteSource);

  User? get cachedUser => _localSource.first?.toDomain();

  Future<void> saveUserLocally(User user) => _localSource.put(user);

  Future<void> deleteLocalUser() => _localSource.clear();

  Future<Either<GenericException, User>> getUserRemote({
    required String uid,
  }) async {
    try {
      final userInfoRM = await _remoteSource.getUserInfo(uid);
      return right(userInfoRM.toDomain());
    } catch (e) {
      return left(e as GenericException);
    }
  }

  Future<Either<GenericException, User>> saveUserInfoRemote({
    required String uid,
    required UserType userType,
    required String coachEmail,
    required String email,
    required String name,
    required String companyName,
    required String phoneNumber,
    required CoachType coachType,
  }) async {
    try {
      final userInfoRM = await _remoteSource.saveUserInfo(
        userType,
        uid: uid,
        coachEmail: coachEmail,
        companyName: companyName,
        email: email,
        name: name,
        phoneNumber: phoneNumber,
        coachType: coachType,
      );
      return right(userInfoRM.toDomain());
    } catch (e) {
      return left(e as GenericException);
    }
  }
}
