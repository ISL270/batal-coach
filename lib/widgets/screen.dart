import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;

  const Screen({
    required this.body,
    this.appBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: body,
        ),
      ),
    );
  }
}
