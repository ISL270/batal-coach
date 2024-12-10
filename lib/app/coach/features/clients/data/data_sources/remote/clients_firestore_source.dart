// ignore_for_file: inference_failure_on_untyped_parameter

import 'package:btl/app/coach/features/clients/data/models/client_fm.dart';
import 'package:btl/app/core/firestore/reactive_firestore_source.dart';
import 'package:btl/app/features/authentication/domain/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@singleton
final class ClientsFirestoreSource extends ReactiveFirestoreSource<ClientFM> {
  ClientsFirestoreSource(super.firestoreSvc);

  @override
  ClientFM fromJson(String docID, Map<String, dynamic> json) => ClientFM.fromJson(json);

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> snapshotQuery(User coach) =>
      firestoreSvc.trainees.collection
          .where(firestoreSvc.trainees.coachEmailField, isEqualTo: coach.email)
          .snapshots();

  @disposeMethod
  void dispMethod() => dispose();
}
