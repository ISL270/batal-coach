import 'package:bloc/bloc.dart';
import 'package:btl/app/features/authentication/data/models/remote/auth_exceptions.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:btl/app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(const LoginState());

  void changeUserType(UserType userType) => emit(state.copyWith(userType: userType));

  void emailChanged(String value) => emit(state.copyWith(email: Email.dirty(value)));

  void passwordChanged(String value) => emit(state.copyWith(password: Password.dirty(value)));

  Future<void> logInWithCredentials() async {
    if (state.isNotValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authRepository.logInWithEmail(
        state.userType,
        email: state.email.value,
        password: state.password.value,
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: (e as LogInWithEmailAndPasswordException).message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    }
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authRepository.logInWithGoogle(state.userType);
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: (e as LogInWithGoogleException).message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    }
  }
}
