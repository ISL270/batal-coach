import 'package:btl/app/coach/features/clients/domain/models/client.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeX on Client {
  String clientLastSeen(BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(lastActiveDate);
    final lastActivity = context.l10n.lastActivity;
    final ago = context.l10n.ago;
    if (difference.inSeconds < 60) {
      return '$lastActivity ${difference.inSeconds} ${context.l10n.seconds} $ago';
    } else if (difference.inMinutes < 60) {
      return '$lastActivity ${difference.inMinutes} ${context.l10n.minutes} '
          '$ago';
    } else if (difference.inHours < 24) {
      return '$lastActivity ${difference.inHours} ${context.l10n.hours} $ago';
    } else if (difference.inDays < 7) {
      return '$lastActivity ${difference.inDays} ${context.l10n.days} $ago';
    } else {
      return DateFormat('yyyy-MM-dd').format(lastActiveDate);
    }
  }
}
