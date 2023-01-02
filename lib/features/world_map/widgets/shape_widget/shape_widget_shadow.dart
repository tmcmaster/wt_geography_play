import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wt_geography_play/features/world_map/models/shape.dart';
import 'package:wt_geography_play/features/world_map/widgets/shape_widget/shape_widget_clip_shadow_path.dart';
import 'package:wt_geography_play/features/world_map/widgets/shape_widget/shape_widget_custom_clip_path.dart';

class ShapeWidgetShadow extends StatelessWidget {
  const ShapeWidgetShadow({
    Key? key,
    required this.shape,
    required this.scale,
    required this.color,
  }) : super(key: key);

  final Shape shape;
  final double scale;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ShapeWidgetClipShadowPath(
        clipper: ShadowWidgetCustomClipPath(
          shape: shape,
          scale: scale,
        ),
        shadow: const Shadow(
          color: Colors.grey,
          offset: Offset(-10, 10),
          blurRadius: 10.0,
        ),
        child: Container(
          color: color,
        ),
      ),
    );
  }
}
