import 'package:btl/app/core/models/firestore_source.dart';
import 'package:btl/app/core/models/generic_exception.dart';
import 'package:btl/app/core/services/firestore_service.dart';
import 'package:btl/app/features/authentication/data/data_sources/remote/user_remote_source.dart';
import 'package:btl/app/features/authentication/data/models/remote/fire_user_info.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UserRemoteSource)
final class UserFirestoreSource extends FirestoreSource implements UserRemoteSource {
  final FirestoreService _firestoreSvc;

  UserFirestoreSource(this._firestoreSvc);

  DocumentReference<Map<String, dynamic>> _userDoc(String id, UserType userType) {
    if (userType.isCoach) {
      return _firestoreSvc.colls.coaches.doc(id);
    }
    return _firestoreSvc.colls.trainees.doc(id);
  }

  @override
  Future<FireUserInfo> getUserInfo(UserType userType, String uid) async {
    return firestoreOperationHandler(() async {
      final userInfoJson = (await _userDoc(uid, userType).get()).data();
      if (userInfoJson == null) throw const BusinessException(code: 'user_not_found');
      return FireUserInfo.fromJson(userType, userInfoJson);
    });
  }

  @override
  Future<FireUserInfo> saveUserInfo(
    UserType userType, {
    required String uid,
    required String coachEmail,
    required String email,
    required String name,
    required String phoneNumber,
  }) async {
    final userInfo = FireUserInfo.fromUserType(
      userType,
      uid: uid,
      coachEmail: coachEmail,
      email: email,
      name: name,
      phoneNumber: phoneNumber,
    );
    return firestoreOperationHandler(() async {
      await _userDoc(uid, userType).set(userInfo.toJson());
      return userInfo;
    });
  }
}
