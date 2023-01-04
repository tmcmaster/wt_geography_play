import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wt_action_button/utils/logging.dart';

class WorldMapShadowPainter extends CustomPainter {
  static final log = logger(WorldMapShadowPainter, level: Level.warning);

  final Shadow shadow;
  final CustomClipper<Path> clipper;

  WorldMapShadowPainter({
    required this.shadow,
    required this.clipper,
  });

  @override
  void paint(Canvas canvas, Size size) {
    log.v('painting');
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool hitTest(Offset position) {
    // TODO: need to review always making this false.
    return false;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: need to review if this can always be false;
    return false;
  }
}
