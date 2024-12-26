import 'package:btl/app/coach/features/add_client/data/data_source/remote/add_client_firestore_source.dart';
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
final class AddClientRepository
    extends ReactiveRepository<Client, ClientFM, ClientIsar> {
  final AddClientFirestoreSource _remoteSource;
  final ClientsIsarSource _localSource;
  final ClientsFirestoreSource _excsRepository;

  AddClientRepository(
    super.authRepository,
    this._remoteSource,
    this._localSource,
    this._excsRepository,
  ) : super(localSource: _localSource, remoteSource: _remoteSource);
  Future<EitherException<void>> saveClient({
    required String coachEmail,
    required String phoneNumber,
    required DateTime lastActive,
    required String name,
    required String phone,
    required String id,
    required String userType,
  }) async {
    try {
      await _remoteSource.saveClient(
        coachEmail: coachEmail,
        phoneNumber: phoneNumber,
        name: name,
        phone: phone,
        id: id,
        lastActive: lastActive,
        userType: userType,
      );
      return right(null);
    } catch (e) {
      return left(e as GenericException);
    }
  }
}
