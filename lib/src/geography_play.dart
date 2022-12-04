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
    final hoverNotifier = ref.watch(InteractiveWorldMap.hover.notifier);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      selectedNotifier
                          .select(Country(id: '9', name: 'Australia'));
                    },
                    child: const Text('Select Australia'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      selectedNotifier.clear();
                    },
                    child: const Text(
                      'Clear Selection',
                    ),
                  ),
                ],
              ),
              const HoverCountry(),
            ],
          ),
        ),
        Expanded(
          child: mapDataSource.when(
              data: (mapDataSource) => InteractiveWorldMap(
                    countryColorMap: countryColorMap,
                    mapDataSource: mapDataSource,
                    selectedNotifier: selectedNotifier,
                    onHover: (country) {
                      if (country != null) {
                        debugPrint('Hovering over Country: $country');
                      }
                      hoverNotifier.state = country;
                    },
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

class HoverCountry extends ConsumerWidget {
  const HoverCountry({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final country = ref.watch(InteractiveWorldMap.hover);
    return Text(
      country?.name ?? '',
      style: const TextStyle(fontSize: 24),
    );
  }
}
