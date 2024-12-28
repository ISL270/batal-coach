import 'package:btl/app/coach/features/edit_client_info/presentaion/selectable_field.dart';
import 'package:btl/app/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/widgets/button.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EditClientInfo extends StatelessWidget {
  const EditClientInfo({super.key});

  static const name = 'editClientInfo';

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          context.l10n.editProfile,
          style: context.textThemeX.large,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              context.l10n.save,
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _ProfileImageWidget(),
            SizedBox(height: 15.h),
            _ProfileFormField(
              label: context.l10n.fName,
              value: 'Amr',
            ),
            _ProfileFormField(
              label: context.l10n.lName,
              value: 'Hossam',
            ),
            _ProfileFormField(
              label: context.l10n.email,
              value: 'amr@gmail.com',
            ),
            _ProfileFormField(
              label: context.l10n.phoneNumber,
              value: '+201146012354',
            ),
            SizedBox(height: 10.h),
            SelectableField(
              context: context,
              label: context.l10n.gender,
              value: context.l10n.male,
              options: [context.l10n.male, context.l10n.female],
            ),
            SizedBox(height: 16.h),
            SelectableField(
              context: context,
              label: context.l10n.clientCategory,
              value: context.l10n.online,
              options: [
                context.l10n.inPerson,
                context.l10n.online,
                context.l10n.hybrid
              ],
            ),
            SizedBox(height: 40.h),
            Button.filled(
              onPressed: () => _showAlertDialog(context),
              label: context.l10n.archiveClient,
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
                  context.l10n.archiveClient,
                  style: context.textThemeX.large.bold,
                ),
                Text(
                  context.l10n.archiveClientConfirmation,
                  style: context.textThemeX.small,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                Button.filled(
                  label: context.l10n.ok,
                  onPressed: () => context.pop(),
                ),
                TextButton(onPressed: () {}, child: Text(context.l10n.cancel))
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProfileImageWidget extends StatelessWidget {
  const _ProfileImageWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: context.colorsX.secondary,
            radius: 45.r,
            child: Text(
              'AH',
              style: context.textThemeX.large.copyWith(
                color: context.colorsX.secondaryBackground,
                fontSize: 24.sp,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff7469DA),
              ),
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 19.w,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ProfileFormField extends StatelessWidget {
  const _ProfileFormField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: SizedBox(
            width: 0.38.sh,
            child: TextFormField(
              initialValue: value,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: context.textThemeX.medium,
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: context.colorsX.onBackgroundTint35),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: context.colorsX.onBackgroundTint35),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
