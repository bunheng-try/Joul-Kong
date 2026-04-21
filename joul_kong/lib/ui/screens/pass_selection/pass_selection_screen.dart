import 'package:flutter/material.dart';
import 'package:joul_kong/data/repositories/pass/pass_repository.dart';
import 'package:joul_kong/ui/screens/pass_selection/view_model/pass_selection_view_model.dart';
import 'package:joul_kong/ui/screens/pass_selection/widgets/pass_selection_content.dart';
import 'package:joul_kong/ui/states/pass_state.dart';
import 'package:provider/provider.dart';

class PassSelectionScreen extends StatelessWidget {
  final String userId;
  const PassSelectionScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PassViewModel(
        repo: context.read<PassRepository>(),
        passState: context.watch<PassState>(),
        userId: userId,
      ),
      child: const PassSelectionContent(),
    );
  }
}
