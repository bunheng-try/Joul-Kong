import 'package:flutter/material.dart';
import 'package:joul_kong/ui/screens/booking/view_model/booking_view_model.dart';
import 'package:joul_kong/ui/theme/app_spacing.dart';
import 'package:joul_kong/ui/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

class NoAccessSection extends StatelessWidget {
  const NoAccessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<BookingViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("No Active Pass or Ticket", style: AppTextStyles.title),

        const SizedBox(height: AppSpacing.md),

        ElevatedButton(
          onPressed: () async {
            await vm.buyTicket();
          },
          child: const Text("Buy Ticket"),
        ),

        const SizedBox(height: 8),

        ElevatedButton(
          onPressed: () {
            // TODO: go to pass screen
          },
          child: const Text("Buy Pass"),
        ),
      ],
    );
  }
}
