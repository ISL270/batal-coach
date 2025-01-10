import 'package:btl/app/core/l10n/l10n.dart';
import 'package:flutter/material.dart';

enum ClientStatus {
  connected('💪', '2'),
  pending('⌛', '0'),
  offline('🛌🏻️', '10');

  final String emoji;
  final String count;

  const ClientStatus(this.emoji, this.count);

  String title(BuildContext context) {
    switch (this) {
      case ClientStatus.connected:
        return context.l10n.connected;
      case ClientStatus.pending:
        return context.l10n.pending;
      case ClientStatus.offline:
        return context.l10n.offline;
    }
  }
}
