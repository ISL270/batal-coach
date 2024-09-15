// ignore_for_file: inference_failure_on_untyped_parameter

import 'package:btl/app/coach/features/clients/data/data_sources/remote/clients_remote_source.dart';
import 'package:btl/app/coach/features/clients/domain/models/client.dart';
import 'package:btl/app/core/models/generic_exception.dart';
import 'package:btl/app/core/models/reactive_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

@singleton
final class ClientsRepository implements ReactiveRepository<List<Client>> {
  final ClientsRemoteSource _remoteSource;

  ClientsRepository(this._remoteSource) {
    _init();
  }

  final _stream = BehaviorSubject<List<Client>>.seeded([]);

  @override
  Stream<List<Client>> getUpdates() => _stream.asBroadcastStream();

  void _init() {
    _remoteSource.stream.listen(
      (rmClients) => _stream.add(rmClients.map((c) => c.toDomain()).toList()),
      onError: (e) => throw e as GenericException,
    );
  }

  @disposeMethod
  void dispose() {
    _remoteSource.dispose();
    _stream.close();
  }
}
