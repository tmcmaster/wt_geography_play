import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/apps/find_country/widgets/hover_country.dart';
import 'package:wt_geography_play/apps/navigate_between/navigate_between_controller.dart';
import 'package:wt_geography_play/apps/navigate_between/widgets/country_neighbours_buttons.dart';
import 'package:wt_geography_play/apps/navigate_between/widgets/navigate_between_objective.dart';
import 'package:wt_geography_play/apps/navigate_between/widgets/navigate_between_score_panel.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_app/world_map_app.dart';
import 'package:wt_logging/wt_logging.dart';

class NavigateBetweenApp extends ConsumerWidget {
  static final log = logger(NavigateBetweenApp, level: Level.warning);

  const NavigateBetweenApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v('Building');
    final controller = ref.read(NavigateBetweenController.provider);

    return WorldMapApp(
      appName: 'Navigate Between',
      controller: controller,
      zoomControls: true,
      refreshButton: false,
      leftHeader: [
        NavigateBetweenObjective(
          controller: controller,
        ),
      ],
      rightHeader: [
        const HoverCountry(),
        controller.reset.button(),
      ],
      leftFooter: [
        CountryNeighboursButtons(
          controller: controller,
        ),
      ],
      infoPanels: [
        NavigateBetweenScorePanel(
          controller: controller,
          alignment: Alignment.bottomCenter,
        ),
      ],
    );
  }
}
