import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@singleton
final class FirestoreService {
  final coaches = _Coaches(FirebaseFirestore.instance);
  final trainees = _Trainees(FirebaseFirestore.instance);
}

final class _Coaches {
  final FirebaseFirestore _firestore;
  _Coaches(this._firestore);

  late final collection = _firestore.collection('coaches');

  late final idField = 'id';
  late final emailField = 'email';
  late final nameField = 'name';
  late final phoneNumberField = 'phoneNumber';
}

final class _Trainees {
  final FirebaseFirestore _firestore;
  _Trainees(this._firestore);

  late final collection = _firestore.collection('trainees');

  late final idField = 'id';
  late final emailField = 'email';
  late final nameField = 'name';
  late final phoneNumberField = 'phoneNumber';
  late final coachEmailField = 'coachEmail';
}
