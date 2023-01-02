import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interactive_world_map/interactive_world_map.dart';
import 'package:interactive_world_map/models/country.dart';
import 'package:interactive_world_map/models/dinosaur.dart';
import 'package:interactive_world_map/providers/country_list.dart';
import 'package:interactive_world_map/providers/providers.dart';

class GeographyPlay extends ConsumerWidget {
  const GeographyPlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dinoByCountry = ref.read(dinosaurByCountryProvider);
    final hoverNotifier = ref.watch(InteractiveWorldMap.hover.notifier);

    return Column(
      children: [
        const _ControlPanel(),
        Expanded(
          child: InteractiveWorldMap(
            onHover: (country) {
              hoverNotifier.state = country;
            },
            onSelect: (country) => _countrySelected(country, dinoByCountry),
            onUnselect: (country) => debugPrint('Country Unselected: $country'),
            onSelectionChanged: (countries) => debugPrint('Selected Countries: $countries'),
          ),
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

class _ControlPanel extends ConsumerWidget {
  const _ControlPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryList = ref.read(countryListProvider);
    final selectedNotifier = ref.watch(InteractiveWorldMap.selected.notifier);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  for (var country in countryList) {
                    selectedNotifier.select(country);
                  }
                },
                child: const Text(
                  'Select All',
                ),
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
          const _HoverCountry(),
        ],
      ),
    );
  }
}

class _HoverCountry extends ConsumerWidget {
  const _HoverCountry({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final country = ref.watch(InteractiveWorldMap.hover);
    return Text(
      country?.name ?? '',
      style: const TextStyle(fontSize: 24),
    );
  }
}
