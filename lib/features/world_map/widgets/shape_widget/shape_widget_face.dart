import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/world_map/models/shape.dart';
import 'package:wt_geography_play/features/world_map/widgets/shape_widget/shape_widget_clip_shadow_path.dart';
import 'package:wt_geography_play/features/world_map/widgets/shape_widget/shape_widget_container.dart';
import 'package:wt_geography_play/features/world_map/widgets/shape_widget/shape_widget_custom_clip_path.dart';

class ShapeWidgetFace extends StatelessWidget {
  static String? hovering;

  final void Function(String country)? onHover;

  const ShapeWidgetFace({
    Key? key,
    required this.shape,
    required this.scale,
    required this.log,
    required this.country,
    required this.onSelect,
    required this.color,
    required this.selectedProvider,
    this.onHover,
  }) : super(key: key);

  final Shape shape;
  final double scale;
  final Logger log;
  final String country;
  final void Function(String country)? onSelect;
  final Color color;
  final AutoDisposeProvider<bool> selectedProvider;

  @override
  Widget build(BuildContext context) {
    return ShapeWidgetClipShadowPath(
      clipper: ShadowWidgetCustomClipPath(
        shape: shape,
        scale: scale,
      ),
      shadow: const Shadow(
        color: Colors.black,
        offset: Offset(0, 0),
        blurRadius: 1.0,
      ),
      child: Listener(
        // onPointerPanZoomUpdate: (event) {
        //   log.v('Zoom : $country');
        // },
        onPointerHover: (event) {
          if (hovering != country) {
            log.v('Hover : $country');
            hovering = country;
            onHover?.call(country);
          }
        },
        child: GestureDetector(
          onTap: () {
            log.v('Tap : $country');
            // notifier.select(country);
            onSelect?.call(country);
          },
          child: ShapeWidgetContainer(
            country: country,
            color: color,
            selectedProvider: selectedProvider,
          ),
        ),
      ),
    );
  }
}
