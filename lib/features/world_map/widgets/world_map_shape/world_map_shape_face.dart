import 'package:flutter/material.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map/world_map_controller.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_shape/world_map_shape_canvas.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_shape/world_map_shape_clipper.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_shape/world_map_shape_outline.dart';

class WorldMapShapeFace extends StatelessWidget {
  static String? hovering;

  final Logger log;
  final String country;
  final Color color;
  final WorldMapShapeClipper clipper;
  final double scale;
  final WorldMapController controller;

  const WorldMapShapeFace({
    super.key,
    required this.clipper,
    required this.log,
    required this.country,
    required this.color,
    required this.scale,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return WorldMapShapeOutline(
      clipper: clipper,
      child: Listener(
        // onPointerPanZoomUpdate: (event) {
        //   log.v('Zoom : $country');
        // },
        onPointerHover: (event) {
          if (hovering != country) {
            log.v('Hover : $country');
            hovering = country;
            controller.onHover(country);
          }
        },
        child: GestureDetector(
          onTap: () {
            log.v('Tap : $country');
            // notifier.select(country);
            controller.onSelect(country);
          },
          child: WorldMapShapeCanvas(
            clipper: clipper,
            country: country,
            color: color,
            selectedProvider: controller.isSelected(country),
          ),
        ),
      ),
    );
  }
}
