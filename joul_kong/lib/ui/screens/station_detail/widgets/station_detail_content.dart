import 'package:flutter/material.dart';
import 'package:joul_kong/ui/screens/station_detail/view_model/station_detail_view_model.dart';
import 'package:joul_kong/ui/screens/station_detail/widgets/available_bikes_section.dart';
import 'package:joul_kong/ui/screens/station_detail/widgets/pricing_section.dart';
import 'package:joul_kong/ui/screens/station_detail/widgets/station_header.dart';
import 'package:joul_kong/ui/screens/station_detail/widgets/station_stats.dart';
import 'package:joul_kong/ui/theme/app_colors.dart';
import 'package:joul_kong/ui/theme/app_spacing.dart';
import 'package:provider/provider.dart';

class StationDetailContent extends StatelessWidget {
  final String stationId;

  const StationDetailContent({super.key, required this.stationId});

  @override
  Widget build(BuildContext context) {
    return Consumer<StationDetailViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,

          body: vm.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        color: AppColors.primary,
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StationHeader(station: vm.station),
                            const SizedBox(height: AppSpacing.lg),
                            StationStats(vm: vm),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AvailableBikesSection(vm: vm),
                            const SizedBox(height: AppSpacing.lg),

                            PricingSection(),
                            const SizedBox(height: AppSpacing.lg),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
