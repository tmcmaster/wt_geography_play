import 'package:flutter/material.dart';
import 'package:wt_geography_play/features/world_map/models/world_map_country.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map/world_map_controller.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_shadow/world_map_shadow_clipper.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_shadow/world_map_shadow_face.dart';

class WorldMapShadow extends StatelessWidget {
  static const defaultColor = Colors.red;

  final List<WorldMapCountry> countries;
  final double scale;
  final Offset offset;
  final Color color;

  const WorldMapShadow({
    super.key,
    required this.countries,
    this.scale = 4.3,
    this.offset = const Offset(0, 0),
    this.color = defaultColor,
  });

  @override
  Widget build(BuildContext context) {
    final region = WorldMapController.countiesToRegion(countries);
    final path = WorldMapController.countriesToPath(
      countries,
      scale: scale,
    );

    return Positioned(
      left: offset.dx,
      top: offset.dy,
      width: region.width * scale,
      height: region.height * scale,
      // TODO: need to move and rename deprecated class from the shape_widget package into the world_map_shadow package and clear out ant old code.
      child: WorldMapShadowFace(
        offset: Offset(scale, scale),
        clipper: WorldMapShadowClipper(path: path),
        color: color,
      ),
    );
  }
}
