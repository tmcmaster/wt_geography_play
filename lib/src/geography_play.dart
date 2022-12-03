import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/src/interactive_world_map.dart';
import 'package:wt_geography_play/src/models/country.dart';
import 'package:wt_geography_play/src/models/dinosaur.dart';
import 'package:wt_geography_play/src/providers.dart';

// ignore: must_be_immutable
class GeographyPlay extends ConsumerWidget {
  const GeographyPlay({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapDataSourceAsync = ref.read(dataSourceFutureProvider);
    final countryColorMap = ref.read(countryColorMapProvider);
    final dinoByCountry = ref.read(dinosaurByCountryProvider);

    return mapDataSourceAsync.when(
      data: (data) => InteractiveWorldMap(
        mapDataSource: data,
        enableHover: true,
        countryColorMap: countryColorMap,
        onSelect: (coutry) => _countrySelected(coutry, dinoByCountry),
        onHover: (country) {
          debugPrint('Hovering over Country: ${country.name}');
        },
      ),
      error: (error, _) => Center(
        child: Text(error.toString()),
      ),
      loading: () => const Center(
        child: Text('Loading...'),
      ),
    );
  }

  void _countrySelected(
    Country country,
    Map<String, List<Dinosaur>> dinoByCountry,
  ) {
    debugPrint('Selected Country: ${country.name}');
    if (dinoByCountry.containsKey(country.name)) {
      for (var dino in dinoByCountry[country.name]!) {
        debugPrint('Selected Dino: ${dino.name}');
      }
    }
  }
}
