import 'dart:developer';
import 'dart:io';

import 'package:btl/app/core/extensions/english_x.dart';
import 'package:btl/app/core/extensions/text_style_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/features/edit_profile/presentation/widgets/edit_profile_items_widget.dart';
import 'package:btl/app/widgets/button.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const name = 'editProfileScreen';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ImagePicker picker = ImagePicker();
  File? _image;

  // Future<void> pickImageButton() async {
  //   try {
  //     final image = await picker.pickImage(source: ImageSource.gallery);
  //     if (image == null) return;
  //     final imageTemp = File(image.path);
  //     setState(() {
  //       this.image = imageTemp;
  //     });
  //   } catch (e) {
  //     log('Failed to pick image : $e');
  //   }
  // }

  //Image Picker function to get image from gallery
  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Image Picker function to get image from camera
  Future<void> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> showOptions() async {
    // ignore: inference_failure_on_function_invocation
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            context.l10n.localeName == 'ar'
                ? Icons.keyboard_arrow_right_sharp
                : Icons.keyboard_arrow_left_sharp,
            size: 28,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        centerTitle: true,
        title: Text(
          context.l10n.profile.capitalized,
          style: context.textThemeX.medium.bold.copyWith(
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const Gap(15),
                  GestureDetector(
                    onTap: showOptions,
                    child: CircleAvatar(
                      radius: 32,
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? const Center(
                              child: Icon(FontAwesomeIcons.cameraRetro),
                            )
                          : null,
                    ),
                  ),
                  const Gap(40),
                  EditProfileItemsWidget(
                    hintLabel: context.l10n.enterfname.capitalized,
                    label: context.l10n.firstname.capitalized,
                  ),
                  const Gap(10),
                  EditProfileItemsWidget(
                    hintLabel: context.l10n.enterlname.capitalized,
                    label: context.l10n.lastname.capitalized,
                  ),
                  const Gap(10),
                  EditProfileItemsWidget(
                    hintLabel: context.l10n.enteryourmobile.capitalized,
                    label: context.l10n.mobile.capitalized,
                  ),
                  const Gap(10),
                  EditProfileItemsWidget(
                    hintLabel: context.l10n.enterbirthdate.capitalized,
                    label: context.l10n.birthdate.capitalized,
                  ),
                  const Gap(10),
                  EditProfileItemsWidget(
                    hintLabel: context.l10n.entergender.capitalized,
                    label: context.l10n.gender.capitalized,
                  ),
                  const Gap(10),
                  EditProfileItemsWidget(
                    hintLabel: context.l10n.enteremail.capitalized,
                    label: context.l10n.email.capitalized,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 175,
            height: 55,
            child: Button.filled(
              label: context.l10n.save.capitalized,
              onPressed: () {
                context.pop();
              },
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
