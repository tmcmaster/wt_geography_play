import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/find_country/widgets/hover_country.dart';
import 'package:wt_geography_play/features/navigate_between/navigate_between_controller.dart';
import 'package:wt_geography_play/features/world_map_app/widgets/info_panel.dart';
import 'package:wt_geography_play/features/world_map_app/world_map_app.dart';

class NavigateBetweenApp extends ConsumerWidget {
  static final log = logger(NavigateBetweenApp, level: Level.warning);

  const NavigateBetweenApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v('Building');
    final controller = ref.read(NavigateBetweenController.provider);

    return WorldMapApp(
      appName: 'Navigate Between',
      zoomControls: true,
      refreshButton: false,
      //onSelect: controller.onSelect,
      onHover: controller.onHover,
      leftHeader: const [
        _Objective(),
      ],
      rightHeader: [
        const HoverCountry(),
        controller.reset.button(),
      ],
      leftFooter: const [
        CountryNeighboursButtons(),
      ],
      rightFooter: const [],
      infoPanels: const [
        _ScorePanel(
          alignment: Alignment.bottomCenter,
        ),
      ],
    );
  }
}

class _Objective extends ConsumerWidget {
  const _Objective({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(NavigateBetweenController.provider);
    final state = ref.watch(controller.state);
    final objective = state.active ? '${state.source} to ${state.destination}' : '';
    return Text(objective,
        style: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 20,
        ));
  }
}

class _ScorePanel extends ConsumerWidget {
  final Alignment alignment;

  const _ScorePanel({
    required this.alignment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(NavigateBetweenController.provider);
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

class CountryNeighboursButtons extends ConsumerWidget {
  const CountryNeighboursButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(NavigateBetweenController.provider);
    final state = ref.watch(controller.state);

    final selected = ref.read(controller.country(state.selected));
    final neighbours = selected?.neighbours ?? ['Australia'];
    return Expanded(
      child: state.completed
          ? const Text(
              'Journey Completed!!',
              style: TextStyle(fontSize: 20, color: Colors.blueGrey),
            )
          : ListView(
              scrollDirection: Axis.horizontal,
              children: neighbours.map((neighbour) => controller.select.button(neighbour)).toList(),
            ),
    );
  }
}
