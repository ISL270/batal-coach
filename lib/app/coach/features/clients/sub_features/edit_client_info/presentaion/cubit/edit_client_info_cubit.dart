// ignore_for_file: only_throw_errors, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:btl/app/core/extension_methods/getit_x.dart';
import 'package:btl/app/core/injection/injection.dart';
import 'package:btl/app/core/models/domain/generic_exception.dart';
import 'package:btl/app/core/models/status.dart';
import 'package:btl/app/features/authentication/domain/models/gender_type.dart';
import 'package:btl/app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_client_info_state.dart';

class EditClientInfoCubit extends Cubit<EditClientInfoState> {
  EditClientInfoCubit() : super(const EditClientInfoState());
  // used for image picker
  final ImagePicker picker = ImagePicker();
  File? _image;
  // used for date picker
  DateTime? pickedDate;
  DateTime selectedDate = DateTime.now();
  DateTime firstDate = DateTime(1920);
  DateTime lastDate = DateTime.now();

  //change gender type state
  void genderTypeChanged(Gender gender) => emit(state.copyWith(gender: gender));

  //change name state
  void nameChanged(String name) => emit(state.copyWith(name: Name.dirty(name)));

  //change Email state
  void emailChanged(String email) => emit(state.copyWith(email: Email.dirty(email)));

  //change phoneNumber state
  void phoneNumberChanged(String phoneNumber) =>
      emit(state.copyWith(phoneNumber: PhoneNumber.dirty(phoneNumber)));

  //Image Picker function to get image from gallery
  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
    emit(state.copyWith(file: _image));
  }

  //Image Picker function to get image from camera
  Future<void> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
    emit(state.copyWith(file: _image));
  }

  //Date Picker Method to get date from calender
  Future<void> selectDate(DateTime pickedDate) async {
    if (pickedDate != selectedDate) {
      selectedDate = pickedDate;
      emit(state.copyWith(date: pickedDate));
    }
  }

  //get user data from local source ( Isar Database )
  Future<void> getUserData() async {
    final user = getIt.authBloc.state.user;

    try {
      emit(state.copyWith(
        name: Name.dirty(user?.name ?? 'no username found'),
        email: Email.dirty(user?.email ?? 'no email address found'),
        phoneNumber: PhoneNumber.dirty(user?.phoneNumber ?? 'no phone number found'),
      ));
      emit(state.copyWith(status: const Success('Successfully get user data')));
    } catch (e) {
      emit(state.copyWith(status: Failure(e as GenericException)));
    }

    log(user.toString());
  }
}
