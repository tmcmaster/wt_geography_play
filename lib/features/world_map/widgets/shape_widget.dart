import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/world_map/models/shape.dart';
import 'package:wt_geography_play/features/world_map/widgets/shape_widget/shape_widget_face.dart';
import 'package:wt_geography_play/features/world_map/widgets/shape_widget/shape_widget_shadow.dart';

class ShapeWidget extends ConsumerWidget {
  static final log = logger(ShapeWidget, level: Level.warning);

  final String country;
  final Shape shape;
  final double scale;
  final Color color;
  final bool shadow;
  final Offset offset;
  final AutoDisposeProvider<bool> selectedProvider;
  final void Function(String country)? onSelect;
  final void Function(String country)? onHover;

  const ShapeWidget({
    super.key,
    required this.country,
    required this.shape,
    this.scale = 1,
    this.color = Colors.red,
    this.shadow = true,
    this.onSelect,
    this.onHover,
    this.offset = const Offset(0, 0),
    required this.selectedProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v('Building Widget : $country : ${shape.region}');
    return Positioned(
      left: (shape.offset.dx + offset.dx) * scale + 10,
      top: (shape.offset.dy + offset.dy) * scale + 10,
      width: shape.size.width * scale + 20,
      height: shape.size.height * scale + 20,
      child: shadow
          ? ShapeWidgetShadow(
              shape: shape,
              scale: scale,
              color: color,
            )
          : ShapeWidgetFace(
              shape: shape,
              scale: scale,
              log: log,
              country: country,
              onSelect: onSelect,
              color: color,
              onHover: onHover,
              selectedProvider: selectedProvider,
            ),
    );
  }
}
