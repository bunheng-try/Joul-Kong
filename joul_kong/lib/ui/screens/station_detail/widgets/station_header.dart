import 'package:flutter/material.dart';
import 'package:joul_kong/models/station.dart';
import 'package:joul_kong/ui/theme/app_colors.dart';
import 'package:joul_kong/ui/theme/app_text_styles.dart';

class StationHeader extends StatelessWidget {
  final Station station;

  const StationHeader({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: AppColors.white),
              ),

              const SizedBox(width: 4),

              Expanded(
                child: Text(
                  station.name,
                  style: AppTextStyles.title.copyWith(color: AppColors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          Padding(
            padding: const EdgeInsets.only(left: 48),
            child: Text(
              "${station.latitude}, ${station.longitude}",
              style: AppTextStyles.subtitle.copyWith(
                color: AppColors.white.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
