import 'package:btl/app/core/extension_methods/name_x.dart';
import 'package:btl/app/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_inputs/form_inputs.dart';

class ClientDetailsUserHeaderInfo extends StatelessWidget {
  const ClientDetailsUserHeaderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xffDD908C),
            radius: 33.sp,
            child: Text(
              const Name.dirty('Amr Hossam').initials,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Amr Hossam - Demo', style: context.textThemeX.heading.bold),
              const SizedBox(height: 4),
              Text(
                '🏡 (GMT-08:00) America/Los_Angeles',
                textAlign: TextAlign.center,
                style: context.textThemeX.small
                    .copyWith(color: Colors.grey, fontSize: 12),
              ),
              Text(
                '⏱︎ 6:19 AM',
                textAlign: TextAlign.center,
                style: context.textThemeX.small
                    .copyWith(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
