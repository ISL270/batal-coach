import 'package:btl/app/features/authentication/data/models/remote/user_info_rm.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';

abstract interface class UserRemoteSource {
  Future<UserInfoRM?> getUserInfo(UserType userType, String uid);
  Future<UserInfoRM> saveUserInfo({
    required String uid,
    required UserType userType,
    required String coachEmail,
  });
}
