import 'package:btl/app/coach/features/clients/data/sources/local/client_isar.dart';
import 'package:btl/app/coach/features/clients/data/sources/local/clients_isar_source.dart';
import 'package:btl/app/coach/features/clients/data/sources/remote/client_fm.dart';
import 'package:btl/app/coach/features/clients/data/sources/remote/clients_firestore_source.dart';
import 'package:btl/app/coach/features/clients/domain/client.dart';
import 'package:btl/app/core/models/domain/generic_exception.dart';
import 'package:btl/app/core/models/reactive_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@singleton
final class ClientsRepository extends ReactiveRepository<Client, ClientFM, ClientIsar> {
  final ClientsIsarSource _localSource;
  final ClientsFirestoreSource _remoteSource;

  ClientsRepository(
    super.authRepository,
    this._remoteSource,
    this._localSource,
  ) : super(localSource: _localSource, remoteSource: _remoteSource);

  Future<EitherException<void>> saveClient({
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      await _remoteSource.saveClient(
        name: name,
        phone: phone,
        email: email,
        coachEmail: authRepository.user!.email,
      );
      return right(null);
    } catch (e) {
      return left(e as GenericException);
    }
  }

  Future<List<Client>> searchClients(
    String searchTerm, {
    required int page,
    required int pageSize,
  }) async {
    final cms = await _localSource.getClients(
      searchTerm,
      page: page,
      pageSize: pageSize,
    );
    return cms.map((e) => e.toDomain()).toList();
  }

  @disposeMethod
  void dispMethod() => dispose();
}
