import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_shadow/world_map_shadow_painter.dart';

class WorldMapShadowFace extends StatelessWidget {
  final Color color;
  final CustomClipper<Path> clipper;
  final Offset offset;

  const WorldMapShadowFace({
    super.key,
    required this.color,
    required this.clipper,
    required this.offset,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: WorldMapShadowPainter(
          clipper: clipper,
          shadow: Shadow(
            color: Colors.grey.shade400,
            offset: offset,
            blurRadius: offset.dx,
          ),
        ),
        child: ClipPath(
          clipper: clipper,
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
