import 'package:btl/app/features/authentication/data/data_sources/local/user_local_source.dart';
import 'package:btl/app/features/authentication/data/data_sources/remote/user_remote_source.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:injectable/injectable.dart';

@singleton
final class UserRepository {
  final UserLocalSource _localSource;
  final UserRemoteSource _remoteSource;

  UserRepository(this._localSource, this._remoteSource);

  Future<User?> getLocalUser() async {
    final userCM = await _localSource.getSavedUser();
    return userCM?.toDomain();
  }

  Future<void> saveUserLocally(User user) => _localSource.saveUser(user);

  Future<void> deleteLocallySavedUser() => _localSource.deleteSavedUser();

  Future<User?> getFullUserRemote({
    required UserType userType,
    required String uid,
    required String email,
    required String? phoneNumber,
    required String? photo,
    required String? name,
  }) async {
    final userInfoRM = await _remoteSource.getUserInfo(userType, uid);
    return userInfoRM?.toDomain(
      uid: uid,
      email: email,
      name: name,
      phoneNumber: phoneNumber,
      photo: photo,
    );
  }

  Future<User> saveUserInfoRemote({
    required String uid,
    required UserType userType,
    required String coachEmail,
    required String email,
    required String? phoneNumber,
    required String? photo,
    required String? name,
  }) async {
    final userInfoRM = await _remoteSource.saveUserInfo(
      uid: uid,
      userType: userType,
      coachEmail: coachEmail,
    );

    return userInfoRM.toDomain(
      uid: uid,
      email: email,
      name: name,
      phoneNumber: phoneNumber,
      photo: photo,
    );
  }
}
