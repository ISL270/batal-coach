import 'package:btl/app/core/firestore/firestore_helper.dart';
import 'package:btl/app/core/firestore/firestore_service.dart';
import 'package:injectable/injectable.dart';

@singleton
final class AddClientFirestoreSource with FirestoreHelper {
  final FirestoreService _firestoreSvc;

  AddClientFirestoreSource(this._firestoreSvc);

  Future<void> saveClient({
    required String coachEmail,
    required String phoneNumber,
    required String name,
    required String phone,
    required String id,
    required String userType,
  }) async =>
      firestoreOperationHandler(() async {
        await _firestoreSvc.trainees.collection.add({
          _firestoreSvc.trainees.coachEmailField: coachEmail,
          _firestoreSvc.trainees.emailField: phoneNumber,
          _firestoreSvc.trainees.nameField: name,
          _firestoreSvc.trainees.phoneNumberField: phone,
          _firestoreSvc.trainees.idField: id,
        });
      });
}
