import 'package:flutter/material.dart';
import 'package:wt_geography_play/features/world_map/models/shape.dart';

class ShapeWidget extends StatelessWidget {
  final Shape shape;
  final double scale;
  final Color color;
  final bool shadow;

  const ShapeWidget({
    super.key,
    required this.shape,
    this.scale = 1,
    this.color = Colors.red,
    this.shadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: shape.offset.dx * scale,
      top: shape.offset.dy * scale,
      width: shape.size.width * scale + 20,
      height: shape.size.height * scale + 20,
      child: Container(
        // color: Colors.yellow,
        padding: const EdgeInsets.all(10),
        child: shadow
            ? ClipShadowPath(
                clipper: CustomClipPath(
                  shape: shape,
                  scale: scale,
                ),
                shadow: const Shadow(
                  color: Colors.grey,
                  offset: Offset(10, 10),
                  blurRadius: 10.0,
                ),
                child: Container(
                  color: color,
                ),
              )
            : ClipPath(
                clipper: CustomClipPath(
                  shape: shape,
                  scale: scale,
                ),
                child: Container(
                  color: color,
                ),
              ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  final Shape shape;
  final double scale;
  CustomClipPath({
    required this.shape,
    this.scale = 1,
  });

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(shape.points[0].x * scale, shape.points[0].y * scale);
    for (var i = 1; i < shape.points.length; i++) {
      path.lineTo(shape.points[i].x * scale, shape.points[i].y * scale);
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  const ClipShadowPath({
    Key? key,
    required this.shadow,
    required this.clipper,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: clipper,
        shadow: shadow,
      ),
      child: ClipPath(
        clipper: clipper,
        child: child,
      ),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
