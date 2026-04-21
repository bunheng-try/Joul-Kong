import 'package:flutter/material.dart';
import 'package:joul_kong/ui/theme/app_text_styles.dart';
import '/ui/theme/app_colors.dart';

class MapHeader extends StatelessWidget {
  final VoidCallback onPassTap;

  const MapHeader({super.key, required this.onPassTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Joul Kong",
              style: AppTextStyles.title.copyWith(color: AppColors.primary),
            ),

            IconButton(
              icon: const Icon(Icons.card_membership, color: AppColors.primary),
              onPressed: onPassTap,
            ),
          ],
        ),
      ),
    );
  }
}
