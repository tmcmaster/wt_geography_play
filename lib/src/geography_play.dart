import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/src/interactive_world_map/interactive_world_map.dart';
import 'package:wt_geography_play/src/models/country.dart';
import 'package:wt_geography_play/src/models/dinosaur.dart';
import 'package:wt_geography_play/src/providers.dart';

class GeographyPlay extends ConsumerWidget {
  const GeographyPlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryColorMap = ref.read(countryColorMapProvider);
    final dinoByCountry = ref.read(dinosaurByCountryProvider);
    final mapDataSource = ref.watch(dataSourceFutureProvider);
    final selectedNotifier = ref.watch(InteractiveWorldMap.selected.notifier);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    selectedNotifier
                        .select(Country(id: '9', name: 'Australia'));
                  },
                  child: const Text('Action'))
            ],
          ),
        ),
        Expanded(
          child: mapDataSource.when(
              data: (mapDataSource) => InteractiveWorldMap(
                    countryColorMap: countryColorMap,
                    mapDataSource: mapDataSource,
                    selectedNotifier: selectedNotifier,
                    onHover: (country) =>
                        debugPrint('Hovering over Country: $country'),
                    onSelect: (country) =>
                        _countrySelected(country, dinoByCountry),
                    onUnselect: (country) =>
                        debugPrint('Country Unselected: $country'),
                    onSelectionChanged: (countries) =>
                        debugPrint('Selected Countries: $countries'),
                  ),
              error: (error, _) =>
                  Center(child: Text('Error: ${error.toString()}')),
              loading: () => const Center(child: Text('Loading...'))),
        ),
      ],
    );
  }

  _countrySelected(Country country, Map<String, List<Dinosaur>> dinoByCountry) {
    debugPrint('Country Selected: $country');
    final dinoList = dinoByCountry[country.name];
    if (dinoList != null) {
      for (var dino in dinoList) {
        debugPrint(' - ${dino.name}');
      }
    }
  }
}
