import 'package:btl/app/coach/features/clients/domain/client.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ClientX on Client {
  String clientLastSeen(BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(lastActiveAt);
    final lastActivity = context.l10n.lastActivity;
    final ago = context.l10n.ago;

    String result;
    if (difference.inSeconds < 60) {
      result = '${difference.inSeconds} ${context.l10n.seconds}';
    } else if (difference.inMinutes < 60) {
      result = '${difference.inMinutes} ${context.l10n.minutes}';
    } else if (difference.inHours < 24) {
      result = '${difference.inHours} ${context.l10n.hours}';
    } else if (difference.inDays < 7) {
      result = '${difference.inDays} ${context.l10n.days}';
    } else {
      return DateFormat('yyyy-MM-dd').format(lastActiveAt);
    }

    return '$lastActivity $result $ago';
  }
}
