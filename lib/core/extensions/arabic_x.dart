import 'package:btl/core/extensions/bloc_x.dart';
import 'package:btl/features/settings/settings/settings_bloc.dart';
import 'package:flutter/widgets.dart';

extension ArabicX on String {
  /// تضيف "ال" لاول الكلمة
  String define(BuildContext context) {
    return context.settingsBloc.state.isArabic ? 'ال$this' : this;
  }
}
