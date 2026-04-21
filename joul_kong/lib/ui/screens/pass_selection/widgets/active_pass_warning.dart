// lib/ui/screens/pass_selection/widgets/active_pass_warning.dart
import 'package:flutter/material.dart';
import 'package:joul_kong/ui/screens/pass_selection/view_model/pass_selection_view_model.dart';
import 'package:joul_kong/ui/theme/app_colors.dart';
import 'package:joul_kong/ui/theme/app_spacing.dart';
import 'package:joul_kong/ui/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

class ActivePassWarning extends StatelessWidget {
  const ActivePassWarning({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<PassViewModel>();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 64, color: AppColors.green),
            const SizedBox(height: AppSpacing.md),
            Text(
              "You already have an active pass!",
              style: AppTextStyles.title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text("Active Pass", style: AppTextStyles.subtitle),
            const SizedBox(height: AppSpacing.sm),
            Text(
              "Valid until: ${_formatDate(vm.activePass?.expiryDate)}",
              style: AppTextStyles.body,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "Unknown";
    return "${date.month}/${date.day}/${date.year}";
  }
}
