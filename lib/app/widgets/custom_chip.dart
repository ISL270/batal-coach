import 'package:flutter/material.dart';

// TODO: Choose a better name for this
class CustomChip extends StatelessWidget {
  const CustomChip({required this.title, required this.isSelected, this.onTap, super.key});

  final bool isSelected;
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool)? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      selected: isSelected,
      selectedColor: Theme.of(context).secondaryHeaderColor,
      onSelected: onTap,
      label: Text(title),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      side: BorderSide.none,
    );
  }
}
