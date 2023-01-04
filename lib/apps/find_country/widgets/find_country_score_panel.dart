import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/apps/find_country/find_country_controller.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_app/world_map_app_info_panel.dart';

class FindCountryScorePanel extends ConsumerWidget {
  final FindCountryController controller;
  final Alignment alignment;

  const FindCountryScorePanel({
    super.key,
    required this.alignment,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(controller.state);

    final progress = (state.completed / state.total * 100).toStringAsFixed(0);
    final percentage = (state.correct / state.total * 100).toStringAsFixed(0);

    final progressString = '${state.completed} of ${state.total} ($progress%)';
    final percentageString = '${state.correct} of ${state.total} ($percentage%)';

    return WorldMapAppInfoPanel(
      title: 'SCORES',
      alignment: alignment,
      size: const Size(400, 130),
      open: state.finished,
      canToggle: !state.finished,
      children: [
        Text('Progress: $progressString'),
        const SizedBox(height: 4),
        Text('Percentage: $percentageString'),
        const SizedBox(height: 4),
        Text('Correct: ${state.correct}  Hints: ${state.hints}  Errors: ${state.errors}'),
      ],
    );
  }
}
