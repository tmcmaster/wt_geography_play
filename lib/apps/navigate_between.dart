import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/interactive_world_map/interactive_world_map.dart';
import 'package:wt_geography_play/providers/country_list.dart';
import 'package:wt_geography_play/providers/country_neighbours.dart';

class NavigateBetween extends StatelessWidget {
  const NavigateBetween({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _ControlPanel(),
        Expanded(
          child: InteractiveWorldMap(),
        ),
      ],
    );
  }
}

class _ControlPanel extends ConsumerWidget {
  const _ControlPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countries = ref.read(countryListProvider);
    final countryNeighbours = ref.read(countryNeighboursProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ElevatedButton(
              onPressed: () {
                for (var country in countries) {
                  if (!countryNeighbours.containsKey(country.name)) {
                    debugPrint(
                        'There is no neighbour data for: ${country.name}');
                  }
                }
              },
              child: const Text('Test')),
        ],
      ),
    );
  }
}
