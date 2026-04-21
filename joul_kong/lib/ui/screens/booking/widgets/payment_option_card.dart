// lib/ui/components/booking/payment_option_card.dart
import 'package:flutter/material.dart';
import 'package:joul_kong/ui/theme/app_colors.dart';
import 'package:joul_kong/ui/theme/app_radius.dart';
import 'package:joul_kong/ui/theme/app_spacing.dart';
import 'package:joul_kong/ui/theme/app_text_styles.dart';
import 'package:joul_kong/ui/theme/app_shadows.dart';

class PaymentOptionCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final String? badgeText;
  final VoidCallback onTap;
  final bool isHighlighted;

  const PaymentOptionCard({
    super.key,
    required this.title,
    required this.price,
    required this.description,
    this.badgeText,
    required this.onTap,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: isHighlighted ? AppColors.cardBgGreen : AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: isHighlighted ? AppColors.primary : AppColors.mute,
          width: isHighlighted ? 2 : 1,
        ),
        boxShadow: isHighlighted ? [AppShadows.soft] : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(title, style: AppTextStyles.subtitle),
                          if (badgeText != null) ...[
                            const SizedBox(width: AppSpacing.sm),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: AppSpacing.xs,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(
                                  AppRadius.sm,
                                ),
                              ),
                              child: Text(
                                badgeText!,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(description, style: AppTextStyles.body),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: AppTextStyles.price.copyWith(
                        color: isHighlighted
                            ? AppColors.primary
                            : AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
