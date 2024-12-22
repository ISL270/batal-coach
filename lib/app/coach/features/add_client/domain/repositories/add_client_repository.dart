import 'package:btl/app/coach/features/add_client/data/remote/add_client_firestore_source.dart';
import 'package:btl/app/core/models/domain/generic_exception.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@singleton
final class AddClientRepository {
  final AddClientFirestoreSource _remoteSource;

  AddClientRepository(this._remoteSource);

  Future<EitherException<void>> saveClient({
    required String coachEmail,
    required String phoneNumber,
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
        userType: userType,
      );
      return right(null);
    } catch (e) {
      return left(e as GenericException);
    }
  }
}
