import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/world_map/models/world_map_country.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map/world_map_canvas.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map/world_map_controller.dart';

class WorldMap extends ConsumerWidget {
  static final log = logger(WorldMap, level: Level.warning);

  final WorldMapController controller;

  const WorldMap({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v('Building Widget');
    ref.watch(WorldMapController.countryCount);
    List<WorldMapCountry> countryList = ref.read(WorldMapController.countryMap).values.toList();
    return FittedBox(
      child: WorldMapCanvas(
        children: controller.fromCountryList(
          countryList,
        ),
      ),
    );
  }
}
