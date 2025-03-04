import 'package:btl/app/coach/features/clients/data/sources/remote/client_fm.dart';
import 'package:btl/app/core/firestore/reactive_firestore_source.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@singleton
final class ClientsFirestoreSource extends ReactiveFirestoreSource<ClientFM> {
  ClientsFirestoreSource(super.firestoreSvc);

  Future<void> saveClient({
    required String name,
    required String email,
    required String phone,
    required String coachEmail,
  }) async =>
      firestoreOperationHandler(() async {
        await firestoreSvc.trainees.collection.add({
          firestoreSvc.trainees.nameField: name,
          firestoreSvc.trainees.emailField: email,
          firestoreSvc.trainees.phoneNumberField: phone,
          firestoreSvc.trainees.coachEmailField: coachEmail,
          firestoreSvc.trainees.lastActiveAtField: FieldValue.serverTimestamp(),
        });
      });

  @override
  ClientFM fromJson(String docID, Map<String, dynamic> json) => ClientFM.fromJson(docID, json);

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> snapshotQuery(User user) =>
      firestoreSvc.trainees.collection
          .where(firestoreSvc.trainees.coachEmailField, isEqualTo: user.email)
          .snapshots();

  @disposeMethod
  void dispMethod() => cancelRemoteSub();

  @override
  Future<void> deleteDoc({required String uid, required String docID}) {
    // TODO: implement deleteDoc
    throw UnimplementedError();
  }
}
