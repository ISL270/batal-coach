import 'package:btl/app/coach/features/clients/domain/models/others_page_items.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OthersTabItemWidget extends StatelessWidget {
  const OthersTabItemWidget({required this.item, super.key});
  final OthersTabItem item;
  @override
  Widget build(BuildContext context) {
    final title = item.getTranslatedTitle(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: context.textThemeX.medium,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              context.pushNamed(item.path);
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
