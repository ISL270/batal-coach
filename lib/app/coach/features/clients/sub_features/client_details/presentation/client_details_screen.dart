import 'package:btl/app/coach/features/clients/domain/client.dart';
import 'package:btl/app/coach/features/clients/sub_features/client_limitaions/presentation/client_limitations_screen.dart';
import 'package:btl/app/coach/features/clients/sub_features/client_goals/presentation/client_goals_screen.dart';
import 'package:btl/app/coach/features/clients/sub_features/client_tasks/presentation/client_tasks_screen.dart';
import 'package:btl/app/core/assets_gen/assets.gen.dart';
import 'package:btl/app/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:go_router/go_router.dart';

part 'widgets/others_tab_view.dart';
part 'widgets/over_view_tab_widget.dart';

class ClientDetailsScreen extends StatelessWidget {
  const ClientDetailsScreen({
    required this.client,
    super.key,
  });
  final Client client;
  static const name = 'client-details';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Screen(
        appBar: AppBar(backgroundColor: context.colorsX.secondaryBackground),
        padding: EdgeInsets.zero,
        body: ColoredBox(
          color: context.colorsX.secondaryBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _ClientDetailsHeaderIcon(
                      icon: Icons.edit,
                      onTap: () {
                        // context.pushNamed(EditClientInfo.name);
                      },
                    ),
                    _ClientDetailsHeaderIcon(
                      icon: Icons.chat,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              _ClientDetailsUserHeaderInfo(client.name, client.lastActiveAt),
              SizedBox(height: 16.h),
              TabBar(
                indicatorColor: context.colorsX.primary, // Tab indicator color
                labelColor: context.colorsX.primary, // Active tab label color
                unselectedLabelColor: context.colorsX.onBackgroundTint, // Inactive tab label color
                tabs: [
                  Tab(text: context.l10n.overview),
                  Tab(text: context.l10n.others),
                ],
              ),
              // Tab Content
              const Expanded(
                child: TabBarView(
                  children: [
                    _OverViewTab(),
                    _OthersTabView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClientDetailsHeaderIcon extends StatelessWidget {
  const _ClientDetailsHeaderIcon({required this.icon, this.onTap});

  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: Container(
          decoration: BoxDecoration(
            color: context.colorsX.onBackgroundTint,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Icon(icon, size: 16.w, color: context.colorsX.background),
          ),
        ),
      ),
    );
  }
}

class _ClientDetailsUserHeaderInfo extends StatelessWidget {
  const _ClientDetailsUserHeaderInfo(this._name, this._lastActiveAt);
  final Name _name;
  final DateTime _lastActiveAt;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: context.colorsX.secondary,
            radius: 33.sp,
            child: Text(
              _name.initials,
              style: TextStyle(
                color: context.colorsX.onBackground,
                fontSize: 24.sp,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_name.value, style: context.textThemeX.heading.bold),
              SizedBox(height: 4.h),
              Text(
                '🏡 (GMT-08:00) America/Los_Angeles',
                textAlign: TextAlign.center,
                style: context.textThemeX.small
                    .copyWith(color: context.colorsX.onBackgroundTint, fontSize: 12.sp),
              ),
              Text(
                '⏱︎ $_lastActiveAt',
                textAlign: TextAlign.center,
                style: context.textThemeX.small
                    .copyWith(color: context.colorsX.onBackgroundTint, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
