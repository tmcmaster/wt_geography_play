import 'package:flutter/material.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_shape/world_map_shape_clipper.dart';

class WorldMapShapeOutline extends StatelessWidget {
  final WorldMapShapeClipper clipper;
  final Widget child;

  const WorldMapShapeOutline({
    Key? key,
    required this.clipper,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
    // return CustomPaint(
    //   painter: WorldMapShapePainter2(
    //     clipper: clipper,
    //   ),
    //   child: child,
    //   // child: ClipPath(
    //   //   clipper: clipper,
    //   //   child: child,
    //   // ),
    // );
  }
}
