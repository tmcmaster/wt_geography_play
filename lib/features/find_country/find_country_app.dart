import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/find_country/providers/next_country_to_find.dart';
import 'package:wt_geography_play/features/find_country/widgets/country_to_find.dart';
import 'package:wt_geography_play/features/find_country/widgets/hover_country.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map.dart';
import 'package:wt_geography_play/features/world_map_app/world_map_app.dart';

class FindCountryApp extends ConsumerWidget {
  static final log = logger(FindCountryApp, level: Level.verbose);

  const FindCountryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v('Building');
    final hoverNotifier = ref.read(WorldMap.hoverCountry.notifier);

    return WorldMapApp(
      zoomControls: true,
      onSelect: (country) {
        final nextCountry = ref.watch(nextCountryToFind);
        if (country == nextCountry) {
          ref.read(WorldMap.selectedCountries.notifier).select(country);
        }
      },
      onHover: (country) {
        hoverNotifier.set(country);
      },
      leftHeader: const [
        CountryToFind(),
      ],
      rightHeader: [
        IconButton(
          icon: const Icon(Icons.question_mark_outlined),
          hoverColor: Colors.transparent,
          onPressed: () {
            final country = ref.read(nextCountryToFind);
            ref.read(WorldMap.selectedCountries.notifier).select(country);
          },
        ),
      ],
      leftFooter: const [
        HoverCountry(),
      ],
      rightFooter: [],
    );
  }
}
