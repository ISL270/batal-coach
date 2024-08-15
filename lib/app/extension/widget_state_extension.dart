import 'package:flutter/material.dart';

extension WidgetStateSet on Set<WidgetState> {
  bool get isHovered => contains(WidgetState.hovered);
  // Add the rest here.
}
