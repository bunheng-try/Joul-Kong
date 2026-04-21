// lib/ui/screens/pass_selection/pass_selection_content.dart
import 'package:flutter/material.dart';
import 'package:joul_kong/models/pass_plan.dart';
import 'package:joul_kong/ui/screens/pass_selection/view_model/pass_selection_view_model.dart';
import 'package:joul_kong/ui/screens/pass_selection/widgets/active_pass_warning.dart';
import 'package:joul_kong/ui/screens/pass_selection/widgets/pass_card.dart';
import 'package:joul_kong/ui/theme/app_colors.dart';
import 'package:joul_kong/ui/theme/app_radius.dart';
import 'package:joul_kong/ui/theme/app_spacing.dart';
import 'package:joul_kong/ui/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

class PassSelectionContent extends StatelessWidget {
  const PassSelectionContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PassViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select a Pass"),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: _buildBody(context, vm),
    );
  }

  Widget _buildBody(BuildContext context, PassViewModel vm) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: AppColors.red),
            const SizedBox(height: AppSpacing.md),
            Text(vm.error!, style: AppTextStyles.body),
            const SizedBox(height: AppSpacing.md),
            ElevatedButton(
              onPressed: vm.clearError,
              child: const Text("Try Again"),
            ),
          ],
        ),
      );
    }

    if (vm.hasValidPass) {
      return const ActivePassWarning();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "You can only have one active pass at a time.",
            style: AppTextStyles.body,
          ),
          Text(
            "Choose the best option for your needs.",
            style: AppTextStyles.body.copyWith(color: AppColors.grey),
          ),
          const SizedBox(height: AppSpacing.lg),

          ...vm.plans.map(
            (plan) => PassCard(
              plan: plan,
              onSelect: () => _showPurchaseDialog(context, plan),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),
          const _WhyChoosePass(),
          const SizedBox(height: AppSpacing.lg),
          const _Footer(),
        ],
      ),
    );
  }


  void _showPurchaseDialog(BuildContext context, PassPlan plan) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text("Purchase ${plan.name} Pass?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Price: \$${plan.price.toStringAsFixed(2)}",
                style: AppTextStyles.subtitle,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                "Duration: ${_getDurationText(plan.durationHours)}",
                style: AppTextStyles.body,
              ),
              if (plan.freeMinutesPerRide != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  "Free minutes per ride: ${plan.freeMinutesPerRide} min",
                  style: AppTextStyles.body,
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              Text(
                "This pass will activate immediately upon purchase.",
                style: AppTextStyles.caption,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
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
              onPressed: () async {
                Navigator.pop(dialogContext);

                final vm = context.read<PassViewModel>();

                final success = await vm.selectPass(plan);

                if (!context.mounted) return;

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "${plan.name} Pass purchased successfully!",
                      ),
                      backgroundColor: AppColors.green,
                    ),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(vm.error ?? "Failed to purchase pass"),
                      backgroundColor: AppColors.red,
                    ),
                  );
                }
              },
              
              child: Text("Purchase", style: AppTextStyles.subtitle.copyWith(color: AppColors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  String _getDurationText(int hours) {
    if (hours >= 24) {
      final days = hours ~/ 24;
      return "$days day${days > 1 ? 's' : ''}";
    }
    return "$hours hour${hours > 1 ? 's' : ''}";
  }
}

class _WhyChoosePass extends StatelessWidget {
  const _WhyChoosePass();


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Why choose a pass?", style: AppTextStyles.subtitle),
          const SizedBox(height: AppSpacing.md),
          _item(Icons.savings, "Save money on multiple rides"),
          const SizedBox(height: AppSpacing.sm),
          _item(Icons.speed, "Skip payment each time"),
          const SizedBox(height: AppSpacing.sm),
          _item(Icons.electric_bike, "Access to premium bikes"),
          const SizedBox(height: AppSpacing.sm),
          _item(Icons.star, "Priority booking when busy"),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: Text(text, style: AppTextStyles.body)),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_outline, size: 14, color: AppColors.grey),
          const SizedBox(width: AppSpacing.sm),
          Text(
            "Secure payment • Cancel anytime",
            style: AppTextStyles.caption.copyWith(color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
