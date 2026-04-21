// lib/ui/screens/booking/widgets/ticket_section.dart
import 'package:flutter/material.dart';
import 'package:joul_kong/ui/screens/booking/widgets/info_row.dart';
import 'package:joul_kong/ui/theme/app_colors.dart';
import 'package:joul_kong/ui/theme/app_radius.dart';
import 'package:joul_kong/ui/theme/app_spacing.dart';
import 'package:joul_kong/ui/theme/app_text_styles.dart';

class TicketSection extends StatelessWidget {
  const TicketSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.cardBgBlue,
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
                  "Single Ticket Active",
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.darkBlue,
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
            "Valid for one ride",
            style: AppTextStyles.body.copyWith(color: AppColors.darkBlue),
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(color: AppColors.primary, height: 1),
          const SizedBox(height: AppSpacing.md),
          InfoRow(
            label: "30 minutes free ride time",
            value: "✓",
            valueColor: AppColors.green,
          ),
          const SizedBox(height: AppSpacing.sm),
          InfoRow(
            label: "No additional charges within free time",
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
                    "After 30 minutes, you'll be charged \$0.25/min",
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.darkBlue,
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
}
