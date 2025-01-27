import 'package:btl/app/core/l10n/l10n.dart';
import 'package:flutter/material.dart';

enum OthersTabItem {
  activityHistory('activityHistory', ''),
  exerciseHistory('exerciseHistory', ''),
  progressPhotos('progressPhotos', ''),
  goal('goal', ''),
  notes('notes', ''),
  limitationsInjuries('limitationsInjuries', ''),
  clientProfile('clientProfile', ''),
  units('units', '/units'),
  features('features', '');

  final String key;
  final String path;

  const OthersTabItem(this.key, this.path);
}

extension OthersTabItemExtension on OthersTabItem {
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
