import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@singleton
final class FirestoreService {
  final colls = _Collections(FirebaseFirestore.instance);
}

final class _Collections {
  final FirebaseFirestore _firestore;
  _Collections(this._firestore);
  late final coaches = _firestore.collection('coaches');
  late final trainees = _firestore.collection('trainees');
}
