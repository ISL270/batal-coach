// ignore_for_file: strict_raw_type

part of 'edit_client_info_cubit.dart';

final class EditClientInfoState extends Equatable with FormzMixin {
  const EditClientInfoState({
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.status = const Initial(),
    this.gender = Gender.male,
    this.file,
    this.date,
  });

  final Name name;
  final Email email;
  final PhoneNumber phoneNumber;
  final Status status;
  final File? file;
  final DateTime? date;
  final Gender? gender;

  EditClientInfoState copyWith({
    Name? name,
    Email? email,
    PhoneNumber? phoneNumber,
    Status? status,
    File? file,
    DateTime? date,
    Gender? gender,
  }) {
    return EditClientInfoState(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      file: file ?? this.file,
      date: date ?? this.date,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        phoneNumber,
        status,
        file,
        date,
        gender,
      ];

  @override
  List<FormzInput> get inputs => [
        name,
        email,
        phoneNumber,
      ];

  String get errorMsg {
    if (!status.isFailure) return '';
    return (status as Failure).exception.message ?? 'unkown error';
  }
}
