import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class TriangleClipper extends CustomClipper<Path> {
  final Size size;
  final Offset offset;

  TriangleClipper({
    required this.size,
    this.offset = const Offset(0.0, 0.0),
  });

  @override
  Path getClip(Size childSize) {
    print('About to clip.');
    final path = Path();
    final dx = offset.dx;
    final dy = offset.dy;

    path.moveTo(dx + 0, dy + size.height);
    path.lineTo(dx + size.width, dy + size.height);
    path.lineTo(dx + size.width / 2, dy + 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => true;

  Float64List _createTranslationMatrix(double dx, double dy) {
    return Float64List.fromList(
      [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, dx, dy, 0, 1],
    );
  }

  Float64List _createRotationTransform(double angle) {
    return Float64List.fromList(
      [cos(angle), sin(angle), 0, 0, -sin(angle), cos(angle), 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
    );
  }
}
