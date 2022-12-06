import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/interactive_world_map/interactive_world_map.dart';
import 'package:wt_geography_play/models/country.dart';
import 'package:wt_geography_play/models/dinosaur.dart';
import 'package:wt_geography_play/providers/providers.dart';

class FindDinosaurs extends ConsumerWidget {
  const FindDinosaurs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoverNotifier = ref.watch(InteractiveWorldMap.hover.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: CountryDinosaurs(),
        ),
        Expanded(
          child: InteractiveWorldMap(
            onHover: (country) {
              hoverNotifier.state = country;
            },
          ),
        ),
      ],
    );
  }
}

class CountryDinosaurs extends ConsumerWidget {
  const CountryDinosaurs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final country = ref.watch(InteractiveWorldMap.hover);
    final dinoByCountry = ref.read(dinosaurByCountryProvider);
    return SizedBox(
      height: 30,
      child: country == null
          ? const SizedBox()
          : Text(
              _generateCountryDinoString(country, dinoByCountry[country.name]),
              style: const TextStyle(fontSize: 24),
            ),
    );
  }

  String _generateCountryDinoString(
      Country? country, List<Dinosaur>? dinoList) {
    return country == null
        ? ''
        : dinoList == null || dinoList.isEmpty
            ? country.name
            : '${country.name}: ${dinoList.map((d) => d.name).join(', ')}';
  }
}
