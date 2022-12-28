import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/world_map/models/country.dart';
import 'package:wt_geography_play/features/world_map/models/geometry.dart';
import 'package:wt_geography_play/features/world_map/providers/country_list.dart';
import 'package:wt_geography_play/features/world_map/widgets/shape_widget.dart';

class WorldMap extends ConsumerWidget {
  const WorldMap({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Country> countryList = ref.watch(countryListProvider3);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shape Stack'),
      ),
      body: Stack(
        children: [true, false]
            .map((shadow) => countryList
                .map((country) => country.shapes
                    .map(
                      (shape) => ShapeWidget(
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
      ),
    );
  }

  List<Geometry> getByCountry(Map<String, List<Geometry>> map, List<String> countries) {
    return countries
        .map((country) {
          List<Geometry> geometry = map[country] ?? [];
          return geometry;
        })
        .toList()
        .expand((list) => list)
        .toList();
  }
}
