import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/find_country/widgets/hover_country.dart';
import 'package:wt_geography_play/features/navigate_between/navigate_between_controller.dart';
import 'package:wt_geography_play/features/world_map_app/widgets/info_panel.dart';
import 'package:wt_geography_play/features/world_map_app/world_map_app.dart';

class NavigateBetweenApp extends ConsumerWidget {
  static final log = logger(NavigateBetweenApp, level: Level.verbose);

  const NavigateBetweenApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v('Building');
    final controller = ref.read(NavigateBetweenController.provider);

    return WorldMapApp(
      appName: 'Race to Country',
      zoomControls: true,
      onSelect: controller.onSelect,
      onHover: controller.onHover,
      leftHeader: [
        controller.clear.button(),
      ],
      rightHeader: const [
        HoverCountry(),
      ],
      leftFooter: const [
        CountryNeighboursButtons(),
      ],
      rightFooter: const [],
      infoPanels: const [
        _ScorePanel(
          alignment: Alignment.bottomLeft,
        ),
      ],
    );
  }
}

class _ScorePanel extends StatelessWidget {
  final Alignment alignment;

  const _ScorePanel({
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: need to get the real values here.
    final distance = 100.0;
    final visitedCountries = 10;
    final currentCountry = 'Australia';

    return InfoPanel(
      alignment: alignment,
      size: const Size(300, 130),
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

    print('State ==>> $state');
    final selected = ref.read(controller.country(state.selected));
    final neighbours = selected?.neighbours ?? ['Australia'];
    return Expanded(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          controller.select.button(state.selected),
          ...neighbours.map((neighbour) => controller.select.button(neighbour)).toList(),
        ],
      ),
    );
  }
}
