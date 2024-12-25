import 'package:btl/app/coach/features/clients/domain/models/client.dart';
import 'package:btl/app/coach/features/clients/domain/models/client_status.dart';
import 'package:btl/app/core/extension_methods/date_x.dart';
import 'package:btl/app/core/extension_methods/string_x.dart';
import 'package:btl/app/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

part 'widgets/clients_list_view.dart';
part 'widgets/clients_status_list_view.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  static const name = 'clients';

  @override
  Widget build(BuildContext context) {
    return Screen(
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.colorsX.primary,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.w)),
        child: Icon(Icons.add, color: context.colorsX.secondaryBackground),
        onPressed: () {},
      ),
      padding: EdgeInsets.zero,
      appBar: AppBar(
        title: Align(
          child: Row(
            children: [
              const Spacer(),
              Icon(Icons.settings, color: context.colorsX.primary),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateTime.now().toFormattedDate(context),
                    style: context.textThemeX.medium.bold.copyWith(
                      fontSize: 16.sp,
                      color: context.colorsX.primary,
                    ),
                  ),
                  Text(
                    context.l10n.allClients,
                    style: context.textThemeX.heading.bold
                        .copyWith(fontSize: 32.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const _ClientsStatusListView(),
                ],
              ),
            ),
            const _ClientsListView(),
          ],
        ),
      ),
    );
  }
}
