import 'package:flutter/material.dart';
import 'package:joul_kong/ui/theme/app_colors.dart';
import 'package:joul_kong/ui/theme/app_text_styles.dart';

class BottomAction extends StatelessWidget {
  final bool hasAccess;
  final VoidCallback onConfirm;

  const BottomAction({super.key, required this.hasAccess, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: hasAccess ? onConfirm : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: hasAccess ? AppColors.primary : AppColors.mute,
          padding: const EdgeInsets.all(16),
        ),
        child: Text(
          "Confirm Booking",
          style: AppTextStyles.subtitle.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
