import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

typedef FiresCollection = CollectionReference<Map<String, dynamic>>;

@singleton
final class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  FiresCollection get coachesColl => _firestore.collection('coaches');
  FiresCollection get traineesColl => _firestore.collection('trainees');
}
