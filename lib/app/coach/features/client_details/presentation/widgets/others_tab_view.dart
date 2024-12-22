part of '../client_details_screen.dart';

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
            return _OthersTabItemWidget(item: item);
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

class _OthersTabItemWidget extends StatelessWidget {
  const _OthersTabItemWidget({required this.item});

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
            onPressed: () => context.pushNamed(item.path),
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
