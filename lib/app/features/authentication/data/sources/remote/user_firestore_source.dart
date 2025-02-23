import 'package:btl/app/core/firestore/firestore_helper.dart';
import 'package:btl/app/core/firestore/firestore_service.dart';
import 'package:btl/app/core/models/domain/generic_exception.dart';
import 'package:btl/app/features/authentication/data/models/remote/fire_user_info.dart';
import 'package:btl/app/features/authentication/domain/models/coach_type.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@singleton
final class UserFirestoreSource with FirestoreHelper {
  final FirestoreService _firestoreSvc;
  UserFirestoreSource(this._firestoreSvc);

  Future<FireUserInfo> getUserInfo(String uid) async {
    return firestoreOperationHandler(() async {
      late final UserType userType;
      late final DocumentSnapshot<Map<String, dynamic>> userDoc;

      // Because Trainees are more than Coaches, assume its a trainee first.
      final trainee = await _firestoreSvc.trainees.collection.doc(uid).get();
      if (trainee.exists) {
        userDoc = trainee;
        userType = UserType.trainee;
      } else {
        // If not a trainee, then surely we'll find the user info in the coaches collection.
        userDoc = await _firestoreSvc.coaches.collection.doc(uid).get();
        userType = UserType.coach;
      }

      if (!userDoc.exists) throw const BusinessException(code: 'user_not_found');
      return FireUserInfo.fromJson(userType, userDoc.data()!);
    });
  }

  Future<FireUserInfo> saveUserInfo(
    UserType userType, {
    required String uid,
    required String coachEmail,
    required String companyName,
    required String email,
    required String name,
    required String phoneNumber,
    required CoachType coachType,
  }) async {
    final userInfo = FireUserInfo.fromUserType(
      userType,
      uid: uid,
      coachEmail: coachEmail,
      email: email,
      name: name,
      companyName: companyName,
      phoneNumber: phoneNumber,
      coachType: coachType,
    );
    return firestoreOperationHandler(() async {
      late final DocumentReference<Map<String, dynamic>> userDoc;
      if (userType.isCoach) {
        userDoc = _firestoreSvc.coaches.collection.doc(uid);
      } else {
        userDoc = _firestoreSvc.trainees.collection.doc(uid);
      }
      await userDoc.set(userInfo.toJson());
      return userInfo;
    });
  }
}
