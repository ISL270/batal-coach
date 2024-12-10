import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:flutter/material.dart';

class CustomIconElevatedButton extends StatelessWidget {
  const CustomIconElevatedButton({
    required this.text,
    this.onPressed,
    this.loading = false,
    super.key,
  });

  final String text;
  final void Function()? onPressed;

  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: context.colorsX.primary,
        ),
        label: loading
            ? Center(
                child: CircularProgressIndicator(
                  color: context.colorsX.background,
                ),
              )
            : Center(
                child: Text(
                  '       $text',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.colorsX.onBackground,
                  ),
                ),
              ),
        icon: Icon(
          Icons.navigate_next_sharp,
          color: context.colorsX.onBackground,
        ),
        iconAlignment: IconAlignment.end,
        onPressed: onPressed,
      ),
    );
  }
}
