import 'package:flutter/material.dart';
import 'package:mysivi_task/constants/app_strings.dart';
import 'package:mysivi_task/constants/app_text_styles.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppStrings.offers, style: AppTextStyles.bodyBold),
    );
  }
}
