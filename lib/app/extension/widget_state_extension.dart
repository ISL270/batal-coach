import 'package:flutter/material.dart';

extension WidgetStateSet on Set<WidgetState> {
  bool get isHovered => contains(WidgetState.hovered);
  bool get isSelected => contains(WidgetState.selected);
  // Add the rest here.
}
