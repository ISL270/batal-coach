// ignore_for_file: inference_failure_on_untyped_parameter

import 'dart:async';

import 'package:btl/app/coach/features/clients/data/data_sources/remote/clients_remote_source.dart';
import 'package:btl/app/coach/features/clients/data/models/fire_client.dart';
import 'package:btl/app/core/models/firestore_source.dart';
import 'package:btl/app/core/models/generic_exception.dart';
import 'package:btl/app/core/services/firestore_service.dart';
import 'package:btl/app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ClientsRemoteSource)
final class ClientsFirestoreSource extends FirestoreSource implements ClientsRemoteSource {
  final FirestoreService _firestoreSvc;
  final AuthRepository _authRepository;

  ClientsFirestoreSource(
    this._firestoreSvc,
    this._authRepository,
  ) {
    _init();
  }

  final _streamCntrlr = StreamController<List<FireClient>>();

  @override
  Stream<List<FireClient>> get stream => _streamCntrlr.stream;

  late final StreamSubscription<QuerySnapshot<Map<String, dynamic>>> _fireClientSubscription;

  void _init() {
    
    _fireClientSubscription = _firestoreSvc.trainees.collection
        .where(_firestoreSvc.trainees.coachEmailField, isEqualTo: _authRepository.user!.email)
        .snapshots()
        .listen(
      (jsonClients) {
        final fireClients = jsonClients.docs.map((c) => FireClient.fromJson(c.data()));
        _streamCntrlr.sink.add(fireClients.toList());
      },
      onError: (e) {
        if (e is FirebaseException) {
          throw BusinessException(code: e.code, message: e.message);
        }
        throw NetworkException.unkown();
      },
    );
  }

  @override
  @disposeMethod
  void dispose() {
    _fireClientSubscription.cancel();
    _streamCntrlr.close();
  }
}
