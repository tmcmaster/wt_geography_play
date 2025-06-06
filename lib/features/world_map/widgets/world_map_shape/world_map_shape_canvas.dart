import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_shape/world_map_shape_clipper.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_shape/world_map_shape_painter.dart';
import 'package:wt_logging/wt_logging.dart';

class WorldMapShapeCanvas extends StatelessWidget {
  static final log = logger(WorldMapShapeCanvas, level: Level.warning);

  const WorldMapShapeCanvas({
    super.key,
    required this.clipper,
    required this.country,
    required this.color,
    required this.selectedProvider,
  });

  final WorldMapShapeClipper clipper;
  final String country;
  final Color color;
  final AutoDisposeProvider<bool> selectedProvider;

  @override
  Widget build(BuildContext context) {
    log.v('Building Widget : $country');

    return Stack(
      children: [
        _SelectionDrivenColor(
          clipper: clipper,
          selectedProvider: selectedProvider,
          color: color,
        ),
        // Container(
        //   color: Colors.white.withOpacity(0.5),
        // ),
      ],
    );
  }
}

// TODO: need to merge this into the class above
class _SelectionDrivenColor extends ConsumerWidget {
  static final log = logger(_SelectionDrivenColor, level: Level.warning);

  final AutoDisposeProvider<bool> selectedProvider;
  final Color color;
  final WorldMapShapeClipper clipper;
  const _SelectionDrivenColor({
    required this.clipper,
    required this.color,
    required this.selectedProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v('Building Widget');

    final selected = ref.watch(selectedProvider);
    return CustomPaint(
      painter: WorldMapShapePainter(
        clipper: clipper,
        selected: selected,
        color: color,
      ),
      child: ClipPath(
        clipper: clipper,
        child: Container(
          color: Colors.transparent,
        ),
      ),
    );
  }
}
