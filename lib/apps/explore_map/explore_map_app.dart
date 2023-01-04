import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/apps/explore_map/explore_map_controller.dart';
import 'package:wt_geography_play/apps/find_country/widgets/hover_country.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_app/world_map_app.dart';

class ExploreMapApp extends ConsumerWidget {
  const ExploreMapApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(ExploreMapController.provider);

    return WorldMapApp(
      appName: 'Explore Map',
      controller: controller,
      zoomControls: true,
      leftFooter: const [
        HoverCountry(),
      ],
    );
  }
}
