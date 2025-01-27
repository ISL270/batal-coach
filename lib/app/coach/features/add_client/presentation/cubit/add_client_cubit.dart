// ignore_for_file: void_checks

import 'package:bloc/bloc.dart';
import 'package:btl/app/coach/features/clients/domain/repositories/clients_repository.dart';
import 'package:btl/app/core/models/domain/generic_exception.dart';
import 'package:btl/app/core/models/status.dart';
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

  void phoneChanged(String value) => emit(state.copyWith(phoneNumber: PhoneNumber.dirty(value)));

  void emailChanged(String value) => emit(state.copyWith(email: Email.dirty(value)));

  Future<void> saveClient() async {
    try {
      emit(state.copyWith(status: const Loading()));
      await _repository.saveClient(
        email: state.email.value,
        name: state.fullName.value,
        phone: state.phoneNumber.value,
      );
      emit(state.copyWith(status: const Success('success')));
    } catch (e) {
      emit(state.copyWith(status: Failure(e as GenericException)));
    }
  }
}
