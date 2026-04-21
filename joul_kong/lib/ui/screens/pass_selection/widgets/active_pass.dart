import 'package:flutter/material.dart';
import 'package:joul_kong/ui/screens/pass_selection/view_model/pass_selection_view_model.dart';
import 'package:joul_kong/ui/theme/app_spacing.dart';
import 'package:joul_kong/ui/widgets/pass_section.dart';
import 'package:provider/provider.dart';

class ActivePass extends StatelessWidget {
  const ActivePass({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PassViewModel>();

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PassSection(pass: vm.passState),

          const SizedBox(height: AppSpacing.lg),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Go Back"),
            ),
          ),
        ],
      ),
    );
  }
}
