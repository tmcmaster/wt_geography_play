import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/src/interactive_world_map.dart';
import 'package:wt_geography_play/src/interactive_world_map_controller.dart';
import 'package:wt_geography_play/src/models/country.dart';
import 'package:wt_geography_play/src/providers.dart';

class GeographyPlay extends ConsumerWidget {
  late InteractiveWorldMapController controller;
  GeographyPlay({Key? key}) : super(key: key) {
    controller = InteractiveWorldMapController(
      selected: {
        Country(id: '154', name: 'Chad'),
      },
      onSelectionChange: (selectedCountries) =>
          debugPrint('Selected Countries: $selectedCountries'),
      onSelect: (country) => debugPrint('Country Selected: $country'),
      onHover: (country) => debugPrint('Hovering over Country: $country'),
      enableHover: true,
    );

    // Timer.periodic(Duration(seconds: 5), (timer) {
    //   final country = Country(id: '154', name: 'Chad');
    //   if (controller.isSelected(country)) {
    //     controller.unselect(country);
    //   } else {
    //     controller.select(country);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryColorMap = ref.read(countryColorMapProvider);
    final dinoByCountry = ref.read(dinosaurByCountryProvider);

    return InteractiveWorldMap(
      countryColorMap: countryColorMap,
      controller: controller,
    );
  }
}
