import 'package:flutter/material.dart';
import 'package:mysivi_task/constants/app_strings.dart';
import 'package:mysivi_task/constants/app_text_styles.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppStrings.settings, style: AppTextStyles.bodyBold),
    );
  }
}
