import 'package:btl/app/coach/features/edit_client_info/presentaion/profile_form_field.dart';
import 'package:btl/app/coach/features/edit_client_info/presentaion/profile_image_widget.dart';
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
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileImageWidget(),
            const SizedBox(
              height: 15,
            ),
            ProfileFormField(
              label: context.l10n.fName,
              value: 'Amr',
            ),
            ProfileFormField(
              label: context.l10n.lName,
              value: 'Hossam',
            ),
            ProfileFormField(
              label: context.l10n.email,
              value: 'amr@gmail.com',
            ),
            ProfileFormField(
              label: context.l10n.phoneNumber,
              value: '+201146012354',
            ),
            SizedBox(
              height: 10.h,
            ),
            SelectableField(
              context: context,
              label: context.l10n.gender,
              value: context.l10n.male,
              options: [context.l10n.male, context.l10n.female],
            ),
            const SizedBox(height: 16),
            SelectableField(
              context: context,
              label: context.l10n.clientCategory,
              value: context.l10n.online,
              options: [context.l10n.inPerson, context.l10n.online, context.l10n.hybrid],
            ),
            const SizedBox(
              height: 40,
            ),
            Button.filled(
              onPressed: () {
                _showAlertDialog(context);
              },
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
          // title: const Text('Alert Dialog'),
          content: SizedBox(
            height: 0.32.sh,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '🗃️',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  context.l10n.archiveClient,
                  style: context.textThemeX.large.bold,
                ),
                Text(
                  context.l10n.archiveClientConfirmation,
                  style: context.textThemeX.small,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Button.filled(
                  label: context.l10n.ok,
                  onPressed: () {
                    context.pop();
                  },
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
