import 'package:bloc/bloc.dart';
import 'package:btl/app/core/enums/status.dart';
import 'package:btl/app/features/authentication/data/models/remote/auth_exceptions.dart';
import 'package:btl/app/features/authentication/domain/models/coach_type.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:btl/app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;
  final pageController = PageController();

  SignUpCubit(this._authRepository) : super(const SignUpState());

  void changeUserType(UserType userType) => emit(state.copyWith(userType: userType));

  void coachTypeChanged(CoachType coachType) => emit(state.copyWith(coachType: coachType));

  void emailChanged(String value) => emit(state.copyWith(email: Email.dirty(value)));

  void nameChanged(String value) => emit(state.copyWith(name: Name.dirty(value)));

  void phoneChanged(String value) {
    final pppp = PhoneNumber.dirty(value);
    emit(state.copyWith(phoneNumber: pppp));
  }

  void coachEmailChanged(String value) => emit(state.copyWith(coachEmail: Email.dirty(value)));

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmPassword.dirty(
      password: password.value,
      value: state.confirmPassword.value,
    );
    emit(state.copyWith(password: password, confirmedPassword: confirmedPassword));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.copyWith(confirmedPassword: confirmedPassword));
  }

  Future<void> signUpFormSubmitted() async {
    emit(state.copyWith(status: const Loading()));
    try {
      await _authRepository.signUp(
        state.userType,
        coachEmail: state.coachEmail.value,
        email: state.email.value,
        name: state.name.value,
        phoneNumber: state.phoneNumber.value,
        password: state.password.value,
        coachType: state.coachType,
      );
    } catch (e) {
      emit(state.copyWith(status: Failure(e as SignUpWithEmailAndPasswordException)));
    }
  }

  bool mainInfoValid() {
    if (state.email.isValid &&
        state.name.isValid &&
        state.password.isValid &&
        state.confirmPassword.isValid) {
      // take first page view info of user
      return true;
    }
    return false;
  }
}
