import 'package:flutter/material.dart';
import 'package:joul_kong/ui/theme/app_colors.dart';
import 'package:joul_kong/ui/theme/app_text_styles.dart';

class AppSuccessDialog {
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = "OK",
    VoidCallback? onPressed,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: const [
              Icon(Icons.check_circle, color: AppColors.green, size: 28),
              SizedBox(width: 8),
              Text("Success", style: AppTextStyles.subtitle),
            ],
          ),
          content: Text(message, style: AppTextStyles.body),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (onPressed != null) onPressed();
              },
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
