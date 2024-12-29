part of 'add_client_cubit.dart';

final class AddClientState extends Equatable with FormzMixin {
  const AddClientState({
    this.fullName = const Name.pure(),
    this.email = const Email.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.status = const Initial(),
  });

  final Name fullName;
  final Email email;
  final PhoneNumber phoneNumber;
  final VoidStatus status;

  @override
  List<Object?> get props => [
        fullName,
        phoneNumber,
        email,
        status,
      ];

  AddClientState copyWith({
    Name? fullName,
    Email? email,
    PhoneNumber? phoneNumber,
    VoidStatus? status,
  }) {
    return AddClientState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
    );
  }

  @override
  // ignore: strict_raw_type
  List<FormzInput> get inputs => [
        fullName,
        phoneNumber,
        email,
      ];

  String get errorMsg {
    if (!status.isFailure) return '';
    return (status as Failure).exception.message ?? 'unknown error';
  }
}
