import 'package:flutter/material.dart';
import 'package:joul_kong/ui/screens/booking/view_model/booking_view_model.dart';
import 'package:joul_kong/ui/screens/booking/widgets/bottom_action.dart';
import 'package:joul_kong/ui/screens/booking/widgets/info_section.dart';
import 'package:joul_kong/ui/screens/booking/widgets/no_access_section.dart';
import 'package:joul_kong/ui/theme/app_text_styles.dart';
import 'package:joul_kong/ui/widgets/pass_section.dart';
import 'package:joul_kong/ui/screens/booking/widgets/ticket_section.dart';
import 'package:joul_kong/ui/states/pass_state.dart';
import 'package:joul_kong/ui/states/ticket_state.dart';
import 'package:joul_kong/ui/theme/app_colors.dart';
import 'package:joul_kong/ui/theme/app_spacing.dart';
import 'package:joul_kong/ui/widgets/app_success_dialog.dart';
import 'package:provider/provider.dart';

class BookingContent extends StatelessWidget {
  const BookingContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BookingViewModel>();
    final pass = context.watch<PassState>();
    final ticket = context.watch<TicketState>();

    final hasPass = pass.hasValidPass;
    final hasTicket = ticket.hasActiveTicket;
    final hasAccess = hasPass || hasTicket;

    if (vm.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Booking", style: AppTextStyles.title,),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InfoSection(),
                    const SizedBox(height: AppSpacing.lg),
                    if (hasPass)
                      PassSection(pass: pass)
                    else if (hasTicket)
                      const TicketSection()
                    else
                      const NoAccessSection(),
                  ],
                ),
              ),
            ),
            BottomAction(
              hasAccess: hasAccess,
              onConfirm: () async {
                final result = await vm.bookBike();
        
                switch (result) {
                  case BookingResult.success:
                    AppSuccessDialog.show(
                      context: context,
                      title: "Booking Confirmed",
                      message: "You have successfully booked a bike.",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );
                    break;
        
                  case BookingResult.noAccess:
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("You need a ticket or pass")),
                    );
                    break;
        
                  case BookingResult.alreadyBooked:
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("You already have a booking")),
                    );
                    break;
        
                  case BookingResult.notFound:
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Bike not found")),
                    );
                    break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
