import 'package:bloc/bloc.dart';
import 'package:btl/app/features/authentication/data/models/remote/auth_exceptions.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:btl/app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;

  SignUpCubit(this._authRepository) : super(const SignUpState());

  void changeUserType(UserType userType) => emit(state.copyWith(userType: userType));

  void emailChanged(String value) => emit(state.copyWith(email: Email.dirty(value)));

  void coachEmailChanged(String value) => emit(state.copyWith(coachEmail: Email.dirty(value)));

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(state.copyWith(password: password, confirmedPassword: confirmedPassword));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.copyWith(confirmedPassword: confirmedPassword));
  }

  Future<void> signUpFormSubmitted() async {
    if (state.isNotValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authRepository.signUp(
        email: state.email.value,
        password: state.password.value,
        userType: state.userType,
        coachEmail: state.coachEmail.value,
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: (e as SignUpWithEmailAndPasswordException).message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    }
  }
}
