part of 'add_client_cubit.dart';

final class AddClientState extends Equatable with FormzMixin {
  final Name name;
  final Email email;
  final VoidStatus status;
  final PhoneNumber phoneNumber;

  const AddClientState({
    this.name = const Name.pure(),
    this.status = const Initial(),
    this.email = const Email.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
  });

  @override
  List<Object?> get props => [
        name,
        email,
        status,
        phoneNumber,
      ];

  AddClientState copyWith({
    Email? email,
    Name? fullName,
    VoidStatus? status,
    PhoneNumber? phoneNumber,
  }) {
    return AddClientState(
      name: fullName ?? name,
      email: email ?? this.email,
      status: status ?? this.status,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  // ignore: strict_raw_type
  List<FormzInput> get inputs => [
        email,
        name,
        phoneNumber,
      ];

  String get errorMsg {
    if (!status.isFailure) return '';
    return (status as Failure).exception.message ?? 'unknown error';
  }
}
