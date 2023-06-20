import 'package:flutter/material.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_shape/world_map_shape_face.dart';
import 'package:wt_logging/wt_logging.dart';

class OceanBackground extends StatelessWidget {
  static final log = logger(OceanBackground, level: Level.verbose);

  const OceanBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log.v('Building Widget');

    return Listener(
      onPointerHover: (event) {
        WorldMapShapeFace.hovering = null;
      },
      child: Opacity(
        opacity: 0.3,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              scale: 1,
              repeat: ImageRepeat.repeat,
              image: AssetImage('assets/ocean_texture.jpeg'),
              // repeat: ImageRepeat.repeat,
            ),
          ),
        ),
      ),
    );
  }
}
