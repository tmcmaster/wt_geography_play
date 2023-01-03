import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/world_map/models/shape.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map/world_map_controller.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_shape/world_map_shape_clipper.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_shape/world_map_shape_face.dart';

class WorldMapShape extends ConsumerWidget {
  static final log = logger(WorldMapShape, level: Level.verbose);

  final String country;
  final Shape shape;
  final double scale;
  final Color color;
  final Offset offset;
  final WorldMapController controller;

  late WorldMapShapeClipper clipper;

  WorldMapShape({
    super.key,
    required this.country,
    required this.shape,
    this.scale = 1,
    this.color = Colors.red,
    required this.controller,
    this.offset = const Offset(0, 0),
  }) {
    clipper = WorldMapShapeClipper(
      shape: shape,
      scale: scale,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v('Building Widget : $country : ${shape.region}');
    return Positioned(
      left: (shape.offset.dx + offset.dx) * scale,
      top: (shape.offset.dy + offset.dy) * scale,
      width: shape.size.width * scale,
      height: shape.size.height * scale,
      child: WorldMapShapeFace(
        clipper: clipper,
        log: log,
        country: country,
        controller: controller,
        color: color,
        scale: scale,
      ),
    );
  }
}
