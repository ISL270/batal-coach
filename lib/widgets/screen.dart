import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry? padding;

  const Screen({
    required this.body,
    this.appBar,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: appBar,
        body: SafeArea(
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
            child: body,
          ),
        ),
      ),
    );
  }
}
