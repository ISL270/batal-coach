import 'package:btl/app/core/services/firestore_service.dart';
import 'package:btl/app/features/authentication/data/data_sources/remote/user_remote_source.dart';
import 'package:btl/app/features/authentication/data/models/remote/fire_user_info.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UserRemoteSource)
final class UserFirestoreSource implements UserRemoteSource {
  final FirestoreService _firestoreSvc;

  UserFirestoreSource(this._firestoreSvc);

  DocumentReference<Map<String, dynamic>> _userDoc(String id, UserType userType) {
    if (userType.isCoach) {
      return _firestoreSvc.coachesColl.doc(id);
    }
    return _firestoreSvc.traineesColl.doc(id);
  }

  @override
  Future<FireUserInfo?> getUserInfo(UserType userType, String uid) async {
    final userInfoJson = (await _userDoc(uid, userType).get()).data();
    return FireUserInfo.fromJson(userType, userInfoJson!);
  }

  @override
  Future<FireUserInfo> saveUserInfo({
    required String uid,
    required UserType userType,
    required String coachEmail,
  }) async {
    final userInfo = switch (userType) {
      UserType.coach => const FireCoachInfo(),
      UserType.trainee => FireTraineeInfo(coachEmail: coachEmail),
    };
    await _userDoc(uid, userType).set(userInfo.toJson());
    return userInfo;
  }
}
