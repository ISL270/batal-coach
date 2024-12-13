import 'dart:developer';

import 'package:btl/app/core/firestore/firestore_helper.dart';
import 'package:btl/app/core/firestore/firestore_service.dart';
import 'package:btl/app/core/models/domain/generic_exception.dart';
import 'package:btl/app/features/authentication/data/models/remote/fire_user_info.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@singleton
final class UserFirestoreSource with FirestoreHelper {
  final FirestoreService _firestoreSvc;
  UserFirestoreSource(this._firestoreSvc);

  DocumentReference<Map<String, dynamic>> _userDoc(String id, UserType userType) {
    if (userType.isCoach) {
      return _firestoreSvc.coaches.collection.doc(id);
    }
    return _firestoreSvc.trainees.collection.doc(id);
  }

  Future<FireUserInfo> getUserInfo(String uid) async {
    return firestoreOperationHandler(() async {
      // userType variable to store returned type of usertype
      final UserType userType;
      // know usertype from firestore {coaches and trainees} collections
      final DocumentSnapshot coachDoc = await _firestoreSvc.coaches.collection.doc(uid).get();
      final DocumentSnapshot traineeDoc = await _firestoreSvc.trainees.collection.doc(uid).get();
      if (coachDoc.exists) {
        // log('its a coach account from uid');
        userType = UserType.coach;
      } else if (traineeDoc.exists) {
        // log('its a trainee account from uid');
        userType = UserType.trainee;
      } else {
        throw const BusinessException(code: 'user_not_found');
      }

      final userInfoJson = (await _userDoc(uid, userType).get()).data();
      if (userInfoJson == null) throw const BusinessException(code: 'user_not_found');
      return FireUserInfo.fromJson(userType, userInfoJson);
    });
  }

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
