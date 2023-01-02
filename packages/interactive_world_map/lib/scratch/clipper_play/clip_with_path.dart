import 'package:flutter/material.dart';

import 'triangle_clipper.dart';

class ClipWithPath extends StatelessWidget {
  final Offset? offset;
  final Size? size;
  final Widget child;

  const ClipWithPath({
    super.key,
    this.size,
    this.offset,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      print(constraints);

      final clipWidth = constraints.maxWidth; //size?.width ?? constraints.maxWidth;
      final clipHeight = constraints.maxHeight; //size?.height ?? constraints.maxHeight;

      final clipLeft = (offset?.dx ?? 0) * -1; // - ((clipWidth - (size?.width ?? 0)) / 2);
      final clipTop = (offset?.dy ?? 0) * -1; // - ((clipHeight - (size?.height ?? 0)) / 2);

      return Container(
        color: Colors.green,
        padding: const EdgeInsets.all(5),
        child: Stack(
          children: [
            Positioned(
              left: clipLeft,
              top: clipTop,
              width: size?.width ?? clipWidth,
              height: size?.height ?? clipHeight,
              // child: child,
              child: ClipPath(
                clipper: TriangleClipper(
                  size: Size(clipWidth, clipHeight),
                  offset: Offset(-clipLeft, -clipTop),
                ),
                child: child,
              ),
            ),
          ],
        ),
      );
    });
  }
}
