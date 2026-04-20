import 'package:flutter/material.dart';
import 'package:joul_kong/ui/screens/booking/view_model/booking_view_model.dart';
import 'package:joul_kong/ui/theme/app_colors.dart';
import 'package:joul_kong/ui/theme/app_radius.dart';
import 'package:joul_kong/ui/theme/app_spacing.dart';
import 'package:provider/provider.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BookingViewModel>();
    final station = vm.station;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.gradient1, AppColors.gradient2],
        ),
        borderRadius: BorderRadius.circular(AppRadius.md)
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Icons.pedal_bike, size: 24, color: Colors.white),
                
                const SizedBox(width: AppSpacing.md),
                
                Text(
                    "Bike ID: ${vm.bikeId}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
    
            const SizedBox(height: 12),
    
            Text(
              station.name,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
    
            const SizedBox(height: 12),
    
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: Colors.white, size: 16,),
                SizedBox(width: AppSpacing.sm,),
                Text(
                  "${station.latitude}, ${station.longitude}",
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
