import 'package:flutter/material.dart' show TextStyle, FontWeight;
import 'package:mysivi_task/constants/app_colors.dart';
import 'package:mysivi_task/constants/app_dimentions.dart';

class AppTextStyles {
  static TextStyle body = TextStyle(
    fontSize: Dimens.sixteen,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static TextStyle bodyBold = TextStyle(
    fontSize: Dimens.twenty,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );
}
