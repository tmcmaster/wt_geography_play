import 'package:flutter/material.dart';
import 'package:wt_geography_play/features/world_map/widgets/shape_widget/shape_widget_clip_shadow_shadow_painter.dart';

class ShapeWidgetClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  const ShapeWidgetClipShadowPath({
    Key? key,
    required this.shadow,
    required this.clipper,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ShapeWidgetClipShadowShadowPainter(
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
