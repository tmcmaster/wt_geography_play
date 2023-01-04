import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/apps/find_country/find_country_controller.dart';
import 'package:wt_geography_play/apps/find_country/widgets/country_to_find.dart';
import 'package:wt_geography_play/apps/find_country/widgets/find_country_score_panel.dart';
import 'package:wt_geography_play/apps/find_country/widgets/hover_country.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_app/world_map_app.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_app/world_map_app_icon_button.dart';

class FindCountryApp extends ConsumerWidget {
  static final log = logger(FindCountryApp, level: Level.verbose);

  const FindCountryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v('Building');
    final controller = ref.read(FindCountryController.provider);

    return WorldMapApp(
      appName: 'Find Country',
      controller: controller,
      zoomControls: true,
      leftHeader: [
        CountryToFind(
          controller: controller,
        ),
      ],
      rightHeader: [
        WorldMapAppIconButton(
          icon: Icons.question_mark_outlined,
          onPressed: () => controller.requestHelp(),
        ),
      ],
      leftFooter: const [
        HoverCountry(),
      ],
      infoPanels: [
        FindCountryScorePanel(
          controller: controller,
          alignment: Alignment.bottomCenter,
        ),
      ],
    );
  }
}
