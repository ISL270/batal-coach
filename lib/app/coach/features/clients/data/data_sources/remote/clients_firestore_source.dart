// ignore_for_file: inference_failure_on_untyped_parameter

import 'dart:async';

import 'package:btl/app/coach/features/clients/data/data_sources/remote/clients_remote_source.dart';
import 'package:btl/app/coach/features/clients/data/models/client_rm.dart';
import 'package:btl/app/coach/features/clients/domain/models/client.dart';
import 'package:btl/app/core/models/firestore_source.dart';
import 'package:btl/app/core/models/generic_exception.dart';
import 'package:btl/app/core/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../models/fire_client.dart';
part 'clients_firestore_source.g.dart';

@LazySingleton(as: ClientsRemoteSource)
final class ClientsFirestoreSource extends FirestoreSource implements ClientsRemoteSource {
  final FirestoreService _firestoreSvc;

  ClientsFirestoreSource(this._firestoreSvc) {
    _createStream();
  }

  late StreamController<List<_FireClient>> _streamCntrlr;

  @override
  Stream<List<ClientRM>> get stream => _streamCntrlr.stream;

  void _createStream() => _streamCntrlr = StreamController<List<_FireClient>>();

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _clientsSubscription;

  @override
  void subToRemote(String coachEmail) {
    if (_streamCntrlr.isClosed) _createStream();
    _clientsSubscription = _firestoreSvc.trainees.collection
        .where(_firestoreSvc.trainees.coachEmailField, isEqualTo: coachEmail)
        .snapshots()
        .listen(
      (jsonClients) {
        final fireClients = jsonClients.docs.map((c) => _FireClient.fromJson(c.data()));
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
  Future<void> cancelRemoteSub() async {
    if (!_streamCntrlr.isClosed) {
      await _streamCntrlr.close();
    }
    await _clientsSubscription?.cancel();
  }

  @override
  @disposeMethod
  void dispose() {
    cancelRemoteSub();
  }
}
