import 'package:batal/core/extension_methods/english_x.dart';
import 'package:batal/core/extension_methods/text_style_x.dart';
import 'package:btl/app/coach/features/clients/sub_features/edit_client_info/presentaion/cubit/edit_client_info_cubit.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/widgets/button.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class EditClientInfo extends StatelessWidget {
  const EditClientInfo({super.key});

  static const name = 'edit-client-info';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditClientInfoCubit>();

    return Screen(
      padding: EdgeInsets.zero,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          context.l10n.editClient,
          style: context.textThemeX.large,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<EditClientInfoCubit, EditClientInfoState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () async {
                    await showCupertinoModalPopup<void>(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                        actions: [
                          CupertinoActionSheetAction(
                            child: Text(context.l10n.gallery.capitalized),
                            onPressed: () {
                              context.pop();
                              cubit.getImageFromGallery();
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: Text(context.l10n.camera.capitalized),
                            onPressed: () {
                              context.pop();
                              cubit.getImageFromCamera();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 40.w,
                    backgroundImage: state.file != null ? FileImage(state.file!) : null,
                    child: state.file == null
                        ? const Center(child: Icon(FontAwesomeIcons.cameraRetro))
                        : null,
                  ),
                );
              },
            ),
            Gap(15.h),
            _ProfileField(label: context.l10n.name, value: 'Andrew - Demo'),
            _ProfileField(label: context.l10n.email, value: 'ben@demo'),
            _ProfileField(label: context.l10n.phoneNumber, value: '201146012354+'),
            _ProfileField(label: context.l10n.birthdate, value: '20/01/2003'),
            _ProfileField(label: context.l10n.gender, value: 'Male'),
            BlocBuilder<EditClientInfoCubit, EditClientInfoState>(
              builder: (context, state) {
                return _ProfileField(
                  label: context.l10n.clientCategory,
                  value: state.clientCategory,
                  isCategory: true,
                );
              },
            ),
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20.w,
              children: [
                Button.filled(
                  height: 50.h,
                  onPressed: () {},
                  label: context.l10n.save,
                ),
                Button.filled(
                  height: 50.h,
                  onPressed: () => _showAlertDialog(context),
                  label: context.l10n.archive,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: context.colorsX.secondaryBackground,
          backgroundColor: context.colorsX.secondaryBackground,
          content: SizedBox(
            height: 0.32.sh,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('🗃️', style: TextStyle(fontSize: 30.sp)),
                SizedBox(height: 10.h),
                Text(
                  context.l10n.archive,
                  style: context.textThemeX.large.bold,
                ),
                Text(
                  context.l10n.archiveClientConfirmation,
                  style: context.textThemeX.small,
                  textAlign: TextAlign.center,
                ),
                Gap(20.h),
                Button.filled(
                  label: context.l10n.ok,
                  onPressed: () => context.pop(),
                ),
                TextButton(onPressed: () => context.pop(), child: Text(context.l10n.cancel))
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProfileField extends StatelessWidget {
  const _ProfileField({required this.label, required this.value, this.isCategory = false});

  final String label;
  final String value;
  final bool isCategory;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditClientInfoCubit>();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      child: Column(
        children: [
          GestureDetector(
            onTap: isCategory
                ? () async {
                    await showCupertinoModalPopup<void>(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                        message: Text(
                          context.l10n.changeClientCategory,
                          style: context.textThemeX.small
                              .copyWith(color: context.colorsX.onBackground),
                        ),
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () {
                              cubit.updateCategory('In-Person');
                              context.pop();
                            },
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque, // Suppresses touch feedback
                              child: Text(
                                context.l10n.inPerson,
                                style: context.textThemeX.large
                                    .copyWith(color: context.colorsX.onBackground),
                              ),
                            ),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              cubit.updateCategory('Online');
                              context.pop();
                            },
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Text(
                                context.l10n.online,
                                style: context.textThemeX.medium
                                    .copyWith(color: context.colorsX.onBackground),
                              ),
                            ),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              cubit.updateCategory('Hybrid');
                              context.pop();
                            },
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Text(
                                context.l10n.hybrid,
                                style: context.textThemeX.medium
                                    .copyWith(color: context.colorsX.onBackground),
                              ),
                            ),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () {
                            context.pop();
                          },
                          child: Text(
                            context.l10n.cancel,
                            style: context.textThemeX.medium.copyWith(color: context.colorsX.error),
                          ),
                        ),
                      ),
                    );
                  }
                : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: context.textThemeX.medium.bold.copyWith(color: Colors.grey),
                ),
                Text(
                  value,
                  style: context.textThemeX.medium.bold,
                ),
              ],
            ),
          ),
          Gap(16.h),
          Divider(
            height: 10.h,
            color: context.colorsX.onBackgroundTint35.withValues(alpha: 0.09),
          )
        ],
      ),
    );
  }
}
