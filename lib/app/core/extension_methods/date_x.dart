import 'package:btl/app/core/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String toMMMM(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    return '${context.l10n.today.toUpperCase()}, $day ${DateFormat.MMMM(locale).format(this)}';
  }
}
