import 'package:btl/app/coach/features/client_details/presentation/widgets/others_tab_item_widget.dart';
import 'package:btl/app/coach/features/clients/domain/models/others_page_items.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:flutter/material.dart';



class OthersTabView extends StatelessWidget {
  const OthersTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      surfaceTintColor: context.colorsX.primary,
      color: context.colorsX.onBackground.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            final item = OthersTabItem.values[index];
            return OthersTabItemWidget(item: item);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey,
            );
          },
          itemCount: OthersTabItem.values.length,
        ),
      ),
    );
  }
}
