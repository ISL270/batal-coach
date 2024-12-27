import 'package:btl/app/coach/features/add_client/presentation/add_client_screen.dart';
import 'package:btl/app/coach/features/clients/domain/models/client.dart';
import 'package:btl/app/coach/features/clients/domain/models/client_status.dart';
import 'package:btl/app/core/extension_methods/client_x.dart';
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
      floatingActionButton: SizedBox(
        width: 65.r,
        height: 65.r,
        child: FloatingActionButton(
          backgroundColor: context.colorsX.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: Icon(
            Icons.add,
            color: context.colorsX.secondaryBackground,
            size: 35.w,
          ),
          onPressed: () => context.pushNamed(AddClientScreen.name),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      appBar: AppBar(
        title: Align(
          child: Row(
            children: [
              const Spacer(),
              Icon(Icons.settings, color: context.colorsX.primary)
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: Text(
                    DateTime.now().toMMMMDate(context),
                    style: context.textThemeX.medium.bold.copyWith(
                      fontSize: 14.sp,
                      color: context.colorsX.primary,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: Text(
                    context.l10n.allClients,
                    style: context.textThemeX.heading.bold
                        .copyWith(fontSize: 32.sp),
                  ),
                ),
                SizedBox(height: 10.h),
                const _ClientsStatusListView(),
              ],
            ),
            const _ClientsListView(),
          ],
        ),
      ),
    );
  }
}
