part of 'add_client_cubit.dart';

final class AddClientState extends Equatable with FormzMixin {
  final Email email;
  final Name fullName;
  final VoidStatus status;
  final PhoneNumber phoneNumber;

  const AddClientState({
    this.status = const Initial(),
    this.email = const Email.pure(),
    this.fullName = const Name.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
  });

  @override
  List<Object?> get props => [
        email,
        status,
        fullName,
        phoneNumber,
      ];

  AddClientState copyWith({
    Email? email,
    Name? fullName,
    VoidStatus? status,
    PhoneNumber? phoneNumber,
  }) {
    return AddClientState(
      email: email ?? this.email,
      status: status ?? this.status,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  // ignore: strict_raw_type
  List<FormzInput> get inputs => [
        email,
        fullName,
        phoneNumber,
      ];

  String get errorMsg {
    if (!status.isFailure) return '';
    return (status as Failure).exception.message ?? 'unknown error';
  }
}
