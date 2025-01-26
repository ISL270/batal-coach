// ignore_for_file: void_checks

import 'package:bloc/bloc.dart';
import 'package:btl/app/coach/features/clients/domain/repositories/clients_repository.dart';
import 'package:btl/app/core/models/domain/generic_exception.dart';
import 'package:btl/app/core/models/status.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

part 'add_client_state.dart';

@injectable
class AddClientCubit extends Cubit<AddClientState> {
  final ClientsRepository _repository;

  AddClientCubit(this._repository) : super(const AddClientState());

  void fullNameChanged(String value) => emit(state.copyWith(fullName: Name.dirty(value)));

  void phoneChanged(String value) {
    final pppp = PhoneNumber.dirty(value);
    emit(state.copyWith(phoneNumber: pppp));
  }

  void emailChanged(String value) => emit(state.copyWith(email: Email.dirty(value)));

  Future<void> saveClient(String coachEmail) async {
    try {
      emit(state.copyWith(status: const Loading()));
      await _repository.saveClient(
        coachEmail: coachEmail,
        phoneNumber: state.phoneNumber.value,
        name: state.fullName.value,
        phone: state.phoneNumber.value,
        userType: UserType.trainee.name,
        lastActiveAt: DateTime.now(),
        email: state.email.value,
      );
      emit(state.copyWith(status: const Success('success')));
    } catch (e) {
      emit(state.copyWith(status: Failure(e as GenericException)));
    }
  }
}
