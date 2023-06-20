import 'package:flutter/material.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_shape/world_map_shape_clipper.dart';
import 'package:wt_logging/wt_logging.dart';

class WorldMapShapePainter extends CustomPainter {
  static final log = logger(WorldMapShapePainter, level: Level.warning);

  final WorldMapShapeClipper clipper;
  final bool selected;
  final Color color;

  WorldMapShapePainter({
    required this.clipper,
    required this.selected,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    log.v('painting');
    final paint = Paint()
      ..color = selected ? color : Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawPath(clipper.path, paint);

    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.grey.shade400
      ..strokeWidth = 1;

    canvas.drawPath(clipper.path, paint);
  }

  @override
  bool hitTest(Offset position) {
    // TODO: need to review always making this false.
    return false;
  }

  @override
  bool shouldRepaint(WorldMapShapePainter oldDelegate) {
    return oldDelegate.selected != selected;
  }
}
