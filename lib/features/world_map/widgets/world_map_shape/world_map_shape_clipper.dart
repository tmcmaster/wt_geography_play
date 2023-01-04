import 'package:flutter/cupertino.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/world_map/models/shape.dart';

class WorldMapShapeClipper extends CustomClipper<Path> {
  static final log = logger(WorldMapShapeClipper, level: Level.warning);
  final Shape shape;
  final double scale;
  late Path path;
  WorldMapShapeClipper({
    required this.shape,
    this.scale = 1,
  }) {
    log.v('Creating ShadowWidgetCustomClipPath');
    path = Path();
    path.moveTo(shape.points[0].x * scale, shape.points[0].y * scale);
    for (var i = 1; i < shape.points.length; i++) {
      path.lineTo(shape.points[i].x * scale, shape.points[i].y * scale);
    }
    path.close();
  }

  @override
  Path getClip(Size size) {
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
