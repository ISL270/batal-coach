import 'package:bloc/bloc.dart';
import 'package:btl/app/coach/features/clients/domain/repositories/clients_repository.dart';
import 'package:btl/app/core/enums/status.dart';
import 'package:btl/app/core/injection/injection.dart';
import 'package:btl/app/core/models/domain/generic_exception.dart';
import 'package:btl/app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

part 'add_client_state.dart';

@injectable
class AddClientCubit extends Cubit<AddClientState> {
  final ClientsRepository _repository;

  AddClientCubit(this._repository) : super(const AddClientState());

  void fNameChanged(String value) => emit(state.copyWith(fName: Name.dirty(value)));

  void lNameChanged(String value) => emit(state.copyWith(lName: Name.dirty(value)));

  void phoneChanged(String value) {
    final pppp = PhoneNumber.dirty(value);
    emit(state.copyWith(phoneNumber: pppp));
  }

  Future<void> saveClient() async {
    try {
      const uuid = Uuid();
      emit(state.copyWith(status: const Loading()));
      final coachEmail = getIt.get<AuthRepository>().user?.email ?? '';
      await _repository.saveClient(
        coachEmail: coachEmail,
        phoneNumber: state.phoneNumber.value,
        name: state.fName.value,
        phone: state.phoneNumber.value,
        id: uuid.v1(),
        userType: 'trainee',
        lastActive: DateTime.now(),
      );
      emit(state.copyWith(status: const Success('success')));
    } catch (e) {
      emit(state.copyWith(status: Failure(e as GenericException)));
    }
  }
}
