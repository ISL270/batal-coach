import 'package:btl/app/coach/features/client_details/presentation/widgets/client_details_header_icon.dart';
import 'package:btl/app/coach/features/client_details/presentation/widgets/client_details_user_header_info.dart';
import 'package:btl/app/coach/features/client_details/presentation/widgets/others_tab_view.dart';
import 'package:btl/app/coach/features/client_details/presentation/widgets/over_view_tab_widget.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/material.dart';

class ClientDetailsScreen extends StatelessWidget {
  const ClientDetailsScreen({super.key});

  static const name = 'ClientDetails';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Screen(
        appBar: AppBar(
          backgroundColor: context.colorsX.secondaryBackground,
        ),
        padding: EdgeInsets.zero,
        body: ColoredBox(
          color: context.colorsX.secondaryBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ClientDetailsHeaderIcon(
                      icon: Icons.edit,
                      onTap: () {
                        // context.pushNamed(EditClientInfo.name);
                      },
                    ),
                    ClientDetailsHeaderIcon(
                      icon: Icons.chat,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const ClientDetailsUserHeaderInfo(),
              const SizedBox(height: 16),
              TabBar(
                indicatorColor: context.colorsX.primary, // Tab indicator color
                labelColor: context.colorsX.primary, // Active tab label color
                unselectedLabelColor: Colors.grey, // Inactive tab label color
                tabs: [
                  Tab(text: context.l10n.overview),
                  Tab(text: context.l10n.others),
                ],
              ),
              // Tab Content
              const Expanded(
                child: TabBarView(
                  children: [
                    OverViewTab(),
                    OthersTabView(),
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
