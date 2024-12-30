import 'package:btl/app/coach/features/clients/data/data_sources/local/client_isar.dart';
import 'package:btl/app/coach/features/clients/data/data_sources/local/clients_isar_source.dart';
import 'package:btl/app/coach/features/clients/data/data_sources/remote/client_fm.dart';
import 'package:btl/app/coach/features/clients/data/data_sources/remote/clients_firestore_source.dart';
import 'package:btl/app/coach/features/clients/domain/models/client.dart';
import 'package:btl/app/core/models/domain/generic_exception.dart';
import 'package:btl/app/core/models/reactive_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@singleton
final class ClientsRepository
    extends ReactiveRepository<Client, ClientFM, ClientIsar> {
  final ClientsFirestoreSource _remoteSource;
  final ClientsIsarSource _localSource;

  ClientsRepository(
    super.authRepository,
    this._remoteSource,
    this._localSource,
  ) : super(
          localSource: _localSource,
          remoteSource: _remoteSource,
        );

  Future<EitherException<void>> saveClient({
    required String coachEmail,
    required String phoneNumber,
    required DateTime lastActive,
    required String name,
    required String email,
    required String phone,
    required String userType,
  }) async {
    try {
      await _remoteSource.saveClient(
        coachEmail: coachEmail,
        phoneNumber: phoneNumber,
        name: name,
        phone: phone,
        email: email,
        lastActive: lastActive,
        userType: userType,
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
