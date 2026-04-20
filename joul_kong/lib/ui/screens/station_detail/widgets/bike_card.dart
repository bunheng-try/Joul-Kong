import 'package:flutter/material.dart';
import 'package:joul_kong/ui/theme/app_colors.dart';
import 'package:joul_kong/ui/theme/app_radius.dart';
import 'package:joul_kong/ui/theme/app_shadows.dart';
import 'package:joul_kong/ui/theme/app_spacing.dart';
import 'package:joul_kong/ui/theme/app_text_styles.dart';

class BikeCard extends StatelessWidget {
  final int slotNumber;
  final String title;
  final String subtitle;
  final bool isAvailable;
  final bool isReserved;
  final bool isEmpty;
  final VoidCallback? onBook;

  const BikeCard({
    super.key,
    required this.slotNumber,
    required this.title,
    required this.subtitle,
    required this.isAvailable,
    required this.isReserved,
    required this.isEmpty,
    this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isAvailable
        ? AppColors.primary.withOpacity(0.06)
        : isReserved
        ? Colors.orange.withOpacity(0.08)
        : Colors.grey.withOpacity(0.05);

    final iconColor = isAvailable
        ? AppColors.primary
        : isReserved
        ? Colors.orange
        : Colors.grey;

    final icon = isAvailable
        ? Icons.pedal_bike
        : isReserved
        ? Icons.schedule
        : Icons.lock;

    final textColor = isEmpty ? Colors.grey : AppColors.black;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [AppShadows.soft],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                slotNumber.toString(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                ),
              ),
            ),
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Row(
              children: [
                Icon(icon, size: 20, color: iconColor),

                const SizedBox(width: 8),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.subtitle.copyWith(
                          color: textColor,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (isAvailable)
            ElevatedButton(
              onPressed: onBook,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
              child: Text(
                "Book",
                style: AppTextStyles.subtitle.copyWith(color: AppColors.white),
              ),
            ),
        ],
      ),
    );
  }
}
