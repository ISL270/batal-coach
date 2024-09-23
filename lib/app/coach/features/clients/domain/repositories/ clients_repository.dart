// ignore_for_file: inference_failure_on_untyped_parameter

import 'package:btl/app/coach/features/clients/data/data_sources/remote/clients_remote_source.dart';
import 'package:btl/app/coach/features/clients/domain/models/client.dart';
import 'package:btl/app/core/models/generic_exception.dart';
import 'package:btl/app/core/models/reactive_repository.dart';
import 'package:btl/app/features/authentication/domain/models/user_x.dart';
import 'package:btl/app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

@singleton
final class ClientsRepository implements ReactiveRepository<List<Client>> {
  final ClientsRemoteSource _remoteSource;
  final AuthRepository _authRepository;

  ClientsRepository(this._remoteSource, this._authRepository) {
    _createSubject();
    _init();
  }

  late BehaviorSubject<List<Client>> _subject;

  void _createSubject() => _subject = BehaviorSubject<List<Client>>.seeded([]);

  void _closeSubject() {
    if (_subject.isClosed) return;
    _subject.close();
  }

  @override
  Stream<List<Client>> getUpdates() => _subject.asBroadcastStream();

  void _init() {
    _authRepository.getUpdates().listen((user) {
      if (user?.isTrainee ?? true) {
        _remoteSource.cancelRemoteSub();
        _closeSubject();
        return;
      }
      
      if (_subject.isClosed) _createSubject();
      _remoteSource.subToRemote(user!.email);
      _remoteSource.stream.listen(
        (rmClients) => _subject.add(rmClients.map((c) => c.toDomain()).toList()),
        // TODO: catch these somehow
        onError: (e) => throw e as GenericException,
      );
    });
  }

  @override
  @disposeMethod
  void dispose() {
    _remoteSource.dispose();
    _closeSubject();
  }
}
