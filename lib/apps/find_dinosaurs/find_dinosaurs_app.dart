import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/apps/find_country/widgets/hover_country.dart';
import 'package:wt_geography_play/apps/find_dinosaurs/find_dinosaurs_controller.dart';
import 'package:wt_geography_play/apps/find_dinosaurs/widgets/dinosaur_collection.dart';
import 'package:wt_geography_play/apps/find_dinosaurs/widgets/found_dinosaur_list.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_app/world_map_app.dart';

class FindDinosaursApp extends ConsumerWidget {
  const FindDinosaursApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(FindDinosaursController.provider);

    return WorldMapApp(
      appName: 'Find Dinosaurs',
      controller: controller,
      zoomControls: true,
      rightHeader: const [
        HoverCountry(),
      ],
      leftFooter: [
        FoundDinosaurList(
          controller: controller,
        ),
      ],
      infoPanels: [
        DinosaurCollection(
          controller: controller,
        ),
      ],
    );
  }
}
