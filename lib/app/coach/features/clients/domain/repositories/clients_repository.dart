import 'package:btl/app/coach/features/clients/data/data_sources/local/clients_isar.dart';
import 'package:btl/app/coach/features/clients/data/data_sources/local/clients_isar_source.dart';
import 'package:btl/app/coach/features/clients/data/data_sources/remote/clients_firestore_source.dart';
import 'package:btl/app/coach/features/clients/data/models/client_fm.dart';
import 'package:btl/app/coach/features/clients/domain/models/client.dart';
import 'package:btl/app/core/enums/status.dart';
import 'package:btl/app/core/models/domain/generic_exception.dart';
import 'package:btl/app/core/models/reactive_repository.dart';
import 'package:btl/app/features/authentication/domain/models/user_x.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

@singleton
final class ClientsRepository
    extends ReactiveRepository<Client, ClientFM, ClientsIsar> {
  final ClientsFirestoreSource _remoteSource;
  final ClientsIsarSource _localSource;

  ClientsRepository(
    super.authRepository,
    this._remoteSource,
    this._localSource,
  ) : super(localSource: _localSource, remoteSource: _remoteSource);

  late BehaviorSubject<Status<List<Client>>> _subject;

  void _createSubject() =>
      _subject = BehaviorSubject<Status<List<Client>>>.seeded(
          const Initial<List<Client>>());

  void _closeSubject() {
    if (_subject.isClosed) return;
    _subject.close();
  }

  @override
  Stream<Status<List<Client>>> getUpdates() => _subject.asBroadcastStream();

  void init() {
    authRepository.getUpdates().listen((user) {
      if (user?.isTrainee ?? true) {
        dispose();
        return;
      }

      if (_subject.isClosed) _createSubject();
      _remoteSource.subToRemote(user!);
      _remoteSource.listToBeUpdated.listen(
        (rmClients) =>
            _subject.add(Success(rmClients.map((c) => c.toDomain()).toList())),
        onError: (Object e) => _subject.add(Failure(e as GenericException)),
      );
    });
  }

  Future<List<Client>> searchClients(
    String searchTerm, {
    required int page,
    required int pageSize,
  }) async {
    final cms = await _localSource.getClients(searchTerm,
        page: page, pageSize: pageSize);
    return cms.map((e) => e.toDomain()).toList();
  }

  @override
  @disposeMethod
  void dispose() {
    _remoteSource.dispose();
    _closeSubject();
  }
}
