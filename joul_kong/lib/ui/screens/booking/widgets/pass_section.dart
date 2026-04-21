import 'package:flutter/material.dart';
import 'package:joul_kong/models/pass_plan.dart';
import 'package:joul_kong/ui/screens/booking/widgets/info_row.dart';
import 'package:joul_kong/ui/states/pass_state.dart';
import 'package:joul_kong/ui/theme/app_colors.dart';
import 'package:joul_kong/ui/theme/app_radius.dart';
import 'package:joul_kong/ui/theme/app_spacing.dart';
import 'package:joul_kong/ui/theme/app_text_styles.dart';

class PassSection extends StatelessWidget {
  final PassState pass;

  const PassSection({super.key, required this.pass});

  PassPlan? _getPlanById(String planId) {
    try {
      return pass.plans.firstWhere((plan) => plan.id == planId);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final activePass = pass.activePass!;
    final plan = _getPlanById(activePass.planId);
    final freeMinutes = plan?.freeMinutesPerRide ?? 30;
    final ratePerMinute = plan?.price ?? 0.25;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.cardBgGreen,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${activePass.planId} Pass Active",
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.darkGreen,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Text(
                  "Active",
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            "Valid until ${_formatDate(activePass.expiryDate)}",
            style: AppTextStyles.body.copyWith(color: AppColors.darkGreen),
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(color: AppColors.primary, height: 1),
          const SizedBox(height: AppSpacing.md),
          InfoRow(
            label: "$freeMinutes minutes free ride time",
            value: "✓",
            valueColor: AppColors.green,
          ),
          const SizedBox(height: AppSpacing.sm),
          InfoRow(
            label: "No additional charges",
            value: "✓",
            valueColor: AppColors.green,
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 20, color: AppColors.lightBlue),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    "After $freeMinutes minutes, you'll be charged \$${ratePerMinute.toStringAsFixed(2)}/min",
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.darkGreen,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${_getMonthName(date.month)} ${date.day}, ${date.year}";
  }

  String _getMonthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[month - 1];
  }
}
