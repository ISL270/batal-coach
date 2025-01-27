part of '../client_details_screen.dart';

class _OthersTabView extends StatelessWidget {
  const _OthersTabView();

  @override
  Widget build(BuildContext context) {
    return Material(
      surfaceTintColor: context.colorsX.primary,
      color: context.colorsX.onBackground.withOpacity(0.05),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            final item = _OthersTabItem.values[index];
            return _OthersTabItemWidget(item: item);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 1,
              thickness: 0.5,
              color: context.colorsX.onBackgroundTint,
            );
          },
          itemCount: _OthersTabItem.values.length,
        ),
      ),
    );
  }
}

class _OthersTabItemWidget extends StatelessWidget {
  const _OthersTabItemWidget({required this.item});

  final _OthersTabItem item;

  @override
  Widget build(BuildContext context) {
    final title = item.getTranslatedTitle(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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

enum _OthersTabItem {
  activityHistory('activityHistory', ''),
  exerciseHistory('exerciseHistory', ''),
  progressPhotos('progressPhotos', ''),
  goal('goal', ClientGoalsScreen.name),
  notes('notes', ''),
  limitationsInjuries('limitationsInjuries', ''),
  clientProfile('clientProfile', ''),
  units('units', '/units'),
  features('features', '');

  final String key;
  final String path;

  const _OthersTabItem(this.key, this.path);

  String getTranslatedTitle(BuildContext context) {
    final l10n = context.l10n;
    switch (key) {
      case 'activityHistory':
        return l10n.activityHistory;
      case 'exerciseHistory':
        return l10n.exerciseHistory;
      case 'progressPhotos':
        return l10n.progressPhotos;
      case 'goal':
        return l10n.goal;
      case 'notes':
        return l10n.notes;
      case 'limitationsInjuries':
        return l10n.limitationsInjuries;
      case 'clientProfile':
        return l10n.clientProfile;
      case 'units':
        return l10n.units;
      case 'features':
        return l10n.features;
      default:
        return '';
    }
  }
}
