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
    if (countryList.isEmpty) {
      return Container();
    }
    final region = WorldMapController.countiesToRegion(countryList);
    final scale = 1600 / region.width;
    final offset = Offset(-region.left, -region.top);
    const shadowOffset = Offset(8, 8);
    final size = Size(
      region.width * scale + shadowOffset.dx,
      region.height * scale + shadowOffset.dy,
    );

    return FittedBox(
      child: WorldMapCanvas(
        size: size,
        children: controller.countriesToWidgets(
          countryList,
          scale: scale,
          offset: offset,
          shadowOffset: shadowOffset,
        ),
      ),
    );
  }
}
