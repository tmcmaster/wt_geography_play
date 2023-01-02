import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/apps/navigate_between/navigate_between_controller.dart';
import 'package:wt_geography_play/features/world_map_app/widgets/info_panel.dart';

class NavigateBetweenScorePanel extends ConsumerWidget {
  final NavigateBetweenController controller;
  final Alignment alignment;

  const NavigateBetweenScorePanel({
    super.key,
    required this.alignment,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(controller.state);

    final distance = state.distance;
    final visitedCountries = state.steps;
    final currentCountry = state.selected;

    return InfoPanel(
      title: 'SCORES',
      alignment: alignment,
      size: const Size(400, 130),
      open: state.completed,
      canToggle: !state.completed,
      children: [
        Text(
          'Distance: ${(distance / 1000).toStringAsFixed(0)} km',
        ),
        const SizedBox(height: 4),
        Text(
          'Visited Countries: $visitedCountries',
        ),
        const SizedBox(height: 4),
        Wrap(
          runSpacing: 3,
          children: [
            const Text(
              'Current Country:',
            ),
            const SizedBox(width: 4),
            ...currentCountry.split(' ').map((word) => Text(' $word')).toList(),
          ],
        ),
      ],
    );
  }
}
