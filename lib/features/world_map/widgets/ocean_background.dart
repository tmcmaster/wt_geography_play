import 'package:flutter/material.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/world_map/widgets/shape_widget/shape_widget_face.dart';

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
        ShapeWidgetFace.hovering = null;
      },
      child: Opacity(
        opacity: 0.2,
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
