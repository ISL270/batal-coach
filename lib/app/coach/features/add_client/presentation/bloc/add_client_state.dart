part of 'add_client_cubit.dart';

final class AddClientState extends Equatable with FormzMixin {
  const AddClientState({
    this.fName = const Name.pure(),
    this.lName = const Name.pure(),
    this.email = const Email.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.status = const Initial(),
  });

  final Name fName;
  final Name lName;
  final Email email;
  final PhoneNumber phoneNumber;
  final VoidStatus status;

  @override
  List<Object?> get props => [
        fName,
        lName,
        phoneNumber,
        email,
        status,
      ];

  AddClientState copyWith({
    Name? fName,
    Name? lName,
    Email? email,
    PhoneNumber? phoneNumber,
    VoidStatus? status,
  }) {
    return AddClientState(
      fName: fName ?? this.fName,
      lName: lName ?? this.lName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
    );
  }

  @override
  // ignore: strict_raw_type
  List<FormzInput> get inputs => [
        fName,
        lName,
        phoneNumber,
        email,
      ];

  String get errorMsg {
    if (!status.isFailure) return '';
    return (status as Failure).exception.message ?? 'unknown error';
  }
}
