import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wt_action_button/utils/logging.dart';

class ShapeWidgetClipShadowPainter extends CustomPainter {
  static final log = logger(ShapeWidgetClipShadowPainter, level: Level.warning);

  final Shadow shadow;
  final CustomClipper<Path> clipper;

  ShapeWidgetClipShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    log.v('painting');
    var paint = shadow.scale(2).toPaint();
    // paint = Paint()..color = Colors.black;
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
