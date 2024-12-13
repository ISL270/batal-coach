// ignore_for_file: inference_failure_on_untyped_parameter

import 'package:btl/app/coach/features/clients/data/data_sources/remote/clients_firestore_source.dart';
import 'package:btl/app/coach/features/clients/domain/models/client.dart';
import 'package:btl/app/core/enums/status.dart';
import 'package:btl/app/core/models/domain/generic_exception.dart';
import 'package:btl/app/features/authentication/domain/models/user_x.dart';
import 'package:btl/app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

@singleton
final class ClientsRepository {
  final ClientsFirestoreSource _remoteSource;
  final AuthRepository _authRepository;

  ClientsRepository(this._remoteSource, this._authRepository) {
    _createSubject();
    _init();
  }

  late BehaviorSubject<Status<List<Client>>> _subject;

  void _createSubject() =>
      _subject = BehaviorSubject<Status<List<Client>>>.seeded(const Initial<List<Client>>());

  void _closeSubject() {
    if (_subject.isClosed) return;
    _subject.close();
  }

  Stream<Status<List<Client>>> getUpdates() => _subject.asBroadcastStream();

  void _init() {
    _authRepository.getUpdates().listen((user) {
      if (user?.isTrainee ?? true) {
        dispose();
        return;
      }

      if (_subject.isClosed) _createSubject();
      _remoteSource.subToRemote(user!);
      _remoteSource.listToBeUpdated.listen(
        (rmClients) => _subject.add(Success(rmClients.map((c) => c.toDomain()).toList())),
        onError: (e) => _subject.add(Failure(e as GenericException)),
      );
    });
  }

  @disposeMethod
  void dispose() {
    _remoteSource.dispose();
    _closeSubject();
  }
}
