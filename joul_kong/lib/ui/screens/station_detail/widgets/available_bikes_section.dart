import 'package:flutter/material.dart';
import 'package:joul_kong/models/enums.dart';
import 'package:joul_kong/ui/screens/booking/booking_screen.dart';
import 'package:joul_kong/ui/screens/station_detail/view_model/station_detail_view_model.dart';
import 'package:joul_kong/ui/screens/station_detail/widgets/bike_card.dart';
import 'package:joul_kong/ui/theme/app_spacing.dart';
import 'package:joul_kong/ui/theme/app_text_styles.dart';

class AvailableBikesSection extends StatelessWidget {
  final StationDetailViewModel vm;

  const AvailableBikesSection({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Station Slots", style: AppTextStyles.title),
        const SizedBox(height: AppSpacing.sm),

        ...vm.slots.asMap().entries.map((entry) {
          final index = entry.key;
          final slot = entry.value;

          final bike = slot.bikeId != null
              ? vm.bikes.firstWhere(
                  (b) => b.id == slot.bikeId,
                  orElse: () => throw Exception(),
                )
              : null;

          final isAvailable = bike?.status == BikeStatus.available;
          final isReserved = bike?.status == BikeStatus.reserved;
          final isEmpty = bike == null;

          return BikeCard(
            slotNumber: index + 1,

            title: isEmpty
                ? "Empty Slot"
                : "Bike ${bike.id}",

            subtitle: isEmpty
                ? "No bike available"
                : isReserved
                ? "Waiting for pickup"
                : "ID: ${bike.id}",

            isAvailable: isAvailable,
            isReserved: isReserved,
            isEmpty: isEmpty,

            onBook: isAvailable
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookingScreen(
                          bikeId: bike!.id,
                          station: vm.station,
                        ),
                      ),
                    );
                  }
                : null,
          );
        }),
      ],
    );
  }
}
