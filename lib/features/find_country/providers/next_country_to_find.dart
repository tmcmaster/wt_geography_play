import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map.dart';

final nextCountryToFind = Provider<String>(
  name: 'Next Country to Find',
  (ref) {
    final countryList = ref.watch(WorldMap.countryMap).values;
    final selectedCountries = ref.watch(WorldMap.selectedCountries);
    if (countryList.isNotEmpty) {
      final remainingCountries =
          countryList.where((country) => !selectedCountries.contains(country.name)).toList();
      if (remainingCountries.isNotEmpty) {
        return remainingCountries[Random().nextInt(remainingCountries.length)].name;
      } else {
        return '';
      }
    } else {
      return '';
    }
  },
);
