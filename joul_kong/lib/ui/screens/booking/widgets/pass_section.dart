import 'package:flutter/material.dart';
import 'package:joul_kong/ui/states/pass_state.dart';
import 'package:joul_kong/ui/theme/app_colors.dart';
import 'package:joul_kong/ui/theme/app_spacing.dart';
import 'package:joul_kong/ui/theme/app_text_styles.dart';

class PassSection extends StatelessWidget {
  final PassState pass;

  const PassSection({super.key, required this.pass});

  @override
  Widget build(BuildContext context) {
    final activePass = pass.activePass!;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardBgGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Active Pass", style: AppTextStyles.title),

          const SizedBox(height: 6),

          Text("Plan: ${activePass.planId}"),
          Text("Expires: ${activePass.expiryDate}"),
        ],
      ),
    );
  }
}
