import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/scroll_pane/scroll_pane.dart';
import 'package:wt_geography_play/features/world_map/models/country.dart';
import 'package:wt_geography_play/features/world_map/providers/country_list.dart';
import 'package:wt_geography_play/features/world_map/providers/selected_countries.dart';
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
    ref.watch(countryCountProvider3);
    List<Country> countryList = ref.read(countryListProvider3);
    return Center(
      child: FittedBox(
        child: MapCanvas(
          oscillate: oscillate,
          children: [true, false]
              .map((shadow) => countryList
                  // .where((country) => country.name == 'Brazil')
                  .map((country) {
                    print('Creating selection providers for ${country.name}');
                    final countrySelectedProvider = isCountrySelected(country.name);
                    return country.shapes
                        .map(
                          (shape) => ShapeWidget(
                            country: country.name,
                            scale: 4.3,
                            shape: shape,
                            color: country.color,
                            shadow: shadow,
                            selectedProvider: countrySelectedProvider,
                          ),
                        )
                        .toList();
                  })
                  .toList()
                  .expand((item) => item)
                  .toList())
              .expand((item) => item)
              .toList(),
        ),
      ),
    );
  }
}

class MapCanvas extends ConsumerWidget {
  const MapCanvas({
    Key? key,
    required this.oscillate,
    required this.children,
  }) : super(key: key);

  final bool oscillate;
  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 1600,
      height: 800,
      child: Stack(
        key: stackKey,
        children: [
          oscillate
              ? const Oscillator(
                  width: 1650,
                  height: 850,
                  duration: 5,
                  interval: 5,
                  magnitude: 50,
                  child: OceanBackground(),
                )
              : const OceanBackground(),
          ...children,
        ],
      ),
    );
  }
}
