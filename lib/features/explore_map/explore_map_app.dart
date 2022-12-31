import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/find_country/widgets/hover_country.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map.dart';
import 'package:wt_geography_play/features/world_map_app/world_map_app.dart';

class ExploreMapApp extends ConsumerWidget {
  const ExploreMapApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoverNotifier = ref.read(WorldMap.hoverCountry.notifier);

    return WorldMapApp(
      appName: 'Explore Map',
      zoomControls: true,
      onSelect: (country) {
        ref.read(WorldMap.selectedCountries.notifier).select(country);
      },
      onHover: (country) {
        hoverNotifier.set(country);
      },
      leftHeader: const [],
      rightHeader: const [],
      leftFooter: const [
        HoverCountry(),
      ],
      rightFooter: [],
    );
  }
}
