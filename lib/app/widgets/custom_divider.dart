import 'package:flutter/material.dart';

//TODO: Give this a better name
class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).dividerColor.withOpacity(0.1),
    );
  }
}
