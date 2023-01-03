import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wt_geography_play/features/world_map/widgets/shape_widget/shape_widget_clip_shadow_path.dart';

class ShapeWidgetShadow extends StatelessWidget {
  final Color color;
  final CustomClipper<Path> clipper;

  const ShapeWidgetShadow({
    super.key,
    required this.color,
    required this.clipper,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ShapeWidgetClipShadowPath(
        clipper: clipper,
        shadow: Shadow(
          color: Colors.grey.shade400,
          offset: const Offset(5, 5),
          blurRadius: 1.0,
        ),
        child: Container(
          color: Colors.transparent,
        ),
      ),
    );
  }
}
