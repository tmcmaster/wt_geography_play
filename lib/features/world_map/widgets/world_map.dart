import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/scroll_pane/scroll_pane.dart';
import 'package:wt_geography_play/features/world_map/models/country.dart';
import 'package:wt_geography_play/features/world_map/providers/country_list.dart';
import 'package:wt_geography_play/features/world_map/widgets/ocean_background.dart';
import 'package:wt_geography_play/features/world_map/widgets/oscillator.dart';
import 'package:wt_geography_play/features/world_map/widgets/shape_widget.dart';

class WorldMap extends ConsumerWidget {
  static final log = logger(WorldMap, level: Level.verbose);

  final bool oscillate;
  const WorldMap({
    super.key,
    this.oscillate = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v('Building Widget');
    List<Country> countryList = ref.watch(countryListProvider3);
    return MapCanvas(
      oscillate: oscillate,
      children: [true, false]
          .map((shadow) => countryList
              .map((country) => country.shapes
                  .map(
                    (shape) => ShapeWidget(
                      country: country.name,
                      scale: 4,
                      shape: shape,
                      color: country.color,
                      shadow: shadow,
                    ),
                  )
                  .toList())
              .toList()
              .expand((item) => item)
              .toList())
          .expand((item) => item)
          .toList(),
    );
  }
}

class MapCanvas extends StatelessWidget {
  const MapCanvas({
    Key? key,
    required this.oscillate,
    required this.children,
  }) : super(key: key);

  final bool oscillate;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      print('Oscillate : $oscillate');
      return Stack(
        key: stackKey,
        children: [
          oscillate
              ? Oscillator(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  duration: 5,
                  interval: 10,
                  child: const OceanBackground(),
                )
              : const OceanBackground(),
          ...children,
        ],
      );
    });
  }
}
