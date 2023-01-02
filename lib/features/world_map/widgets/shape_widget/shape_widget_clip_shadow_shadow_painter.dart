import 'dart:ui';

import 'package:flutter/material.dart';

class ShapeWidgetClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  ShapeWidgetClipShadowShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool hitTest(Offset position) {
    // TODO: need to review always making this false.
    return false;
    // Path path = Path();
    // path.close();
    // return path.contains(position);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
