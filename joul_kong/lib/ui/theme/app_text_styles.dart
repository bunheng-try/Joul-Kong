import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.darkGrey,
  );

  static const TextStyle body = TextStyle(fontSize: 14, color: AppColors.grey);

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.lightGrey,
  );

  static const TextStyle price = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
}
