// lib/ui/screens/booking/widgets/no_access_section.dart
import 'package:flutter/material.dart';
import 'package:joul_kong/ui/screens/booking/widgets/payment_option_card.dart';
import 'package:joul_kong/ui/theme/app_colors.dart';
import 'package:joul_kong/ui/theme/app_radius.dart';
import 'package:joul_kong/ui/theme/app_spacing.dart';
import 'package:joul_kong/ui/theme/app_text_styles.dart';
import 'package:provider/provider.dart';
import '../view_model/booking_view_model.dart';

class NoAccessSection extends StatelessWidget {
  const NoAccessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<BookingViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('No Active Pass', style: AppTextStyles.title),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Choose an option below to complete your booking',
          style: AppTextStyles.body,
        ),
        const SizedBox(height: AppSpacing.lg),

        Text('Select Payment Option', style: AppTextStyles.subtitle),
        const SizedBox(height: AppSpacing.md),

        PaymentOptionCard(
          title: 'Single Ticket',
          price: '\$3.50',
          description:
              'One-time ride, 30 minutes included\nValid for this ride only',
          onTap: () => vm.buyTicket(),
        ),

        PaymentOptionCard(
          title: 'Buy a Pass',
          price: 'Save More',
          description:
              'Unlimited rides with longer free minutes\nDay Pass: \$8.99 • Monthly: \$29.99 • Annual: \$199.99',
          badgeText: 'Best Value',
          onTap: () => null,
          // isHighlighted: true,
        ),

        const SizedBox(height: AppSpacing.lg),

        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            children: [
              Icon(Icons.lock_outline, size: 16, color: AppColors.grey),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Secure checkout with encryption',
                style: AppTextStyles.caption.copyWith(color: AppColors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
