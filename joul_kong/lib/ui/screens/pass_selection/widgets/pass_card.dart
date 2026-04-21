// lib/ui/screens/pass_selection/widgets/pass_card.dart
import 'package:flutter/material.dart';
import 'package:joul_kong/models/pass_plan.dart';
import 'package:joul_kong/ui/theme/app_colors.dart';
import 'package:joul_kong/ui/theme/app_spacing.dart';
import 'package:joul_kong/ui/theme/app_text_styles.dart';

class PassCard extends StatelessWidget {
  final PassPlan plan;
  final VoidCallback onSelect;

  const PassCard({super.key, required this.plan, required this.onSelect});

  String _getDurationText() {
    final hours = plan.durationHours;
    if (hours >= 24) {
      final days = hours ~/ 24;
      return "$days day${days > 1 ? 's' : ''}";
    }
    return "$hours hour${hours > 1 ? 's' : ''}";
  }

  Color _getAccentColor() {
    final name = plan.name.toLowerCase();
    if (name.contains('day')) {
      return AppColors.dayPass;
    } else if (name.contains('month')) {
      return AppColors.monthPass;
    } else if (name.contains('annual') || name.contains('year')) {
      return AppColors.yearPass;
    }
    return AppColors.primary;
  }

  Color _getBackgroundColor() {
    final name = plan.name.toLowerCase();
    if (name.contains('day')) {
      return AppColors.cardBgBlue;
    } else if (name.contains('month')) {
      return AppColors.cardBgGreen;
    } else if (name.contains('annual') || name.contains('year')) {
      return AppColors.cardBgRed;
    }
    return AppColors.backgroundColor;
  }

  String _getBadgeText() {
    final name = plan.name.toLowerCase();
    if (name.contains('day')) {
      return "Day Pass";
    } else if (name.contains('month')) {
      return "Best Value";
    } else if (name.contains('annual') || name.contains('year')) {
      return "Save 44%";
    }
    return plan.name;
  }

  bool _isMonthly() {
    return plan.name.toLowerCase().contains('month');
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = _getAccentColor();
    final backgroundColor = _getBackgroundColor();
    final isMonthly = _isMonthly();

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getBadgeText(),
                  style: AppTextStyles.subtitle.copyWith(color: Colors.white),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    plan.name,
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),


          // Content
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Price
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${plan.price.toStringAsFixed(2)}",
                      style: AppTextStyles.title.copyWith(
                        color: accentColor,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      _getDurationText(),
                      style: AppTextStyles.body.copyWith(color: AppColors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                // Benefits
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 18,
                        color: AppColors.green,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          "Unlimited ${plan.freeMinutesPerRide ?? 30}-minute rides",
                          style: AppTextStyles.body,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 18,
                        color: AppColors.green,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      const Expanded(
                        child: Text(
                          "Access to all bikes",
                          style: AppTextStyles.body,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 18,
                        color: AppColors.green,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          "Valid ${_getDurationText()}",
                          style: AppTextStyles.body,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 18,
                        color: AppColors.green,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      const Expanded(
                        child: Text(
                          "Starts on purchase",
                          style: AppTextStyles.body,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),


                // Validity info
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14, color: AppColors.grey),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      "Valid ${_getDurationText()}",
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Icon(Icons.timer, size: 14, color: AppColors.grey),
                    const SizedBox(width: AppSpacing.sm),
                    Text("Starts on purchase", style: AppTextStyles.caption),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onSelect,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                      ),
                    ),
                    child: Text("Buy ${plan.name} Pass"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
