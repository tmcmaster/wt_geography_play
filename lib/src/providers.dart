import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vector_map/vector_map.dart';
import 'package:wt_geography_play/src/models/country.dart';
import 'package:wt_geography_play/src/models/dinosaur.dart';

final dataSourceFutureProvider = FutureProvider(
  (ref) async {
    String geoJson = await rootBundle.loadString('assets/world_countries.json');
    return MapDataSource.geoJson(geoJson: geoJson, labelKey: 'name');
  },
);

final countryColorMapProvider = Provider<Map<String, Color>>(
  (ref) => {
    'Australia': Colors.yellow,
    'USA': Colors.blue,
    'China': Colors.red,
  },
);

final dinosaurListProvider = Provider<List<Dinosaur>>(
  (ref) => [
    Dinosaur(id: '001', name: 'Stegie', country: 'USA'),
    Dinosaur(id: '002', name: 'Apatasaurus', country: 'USA'),
  ],
);

final dinosaurByCountryProvider = Provider<Map<String, List<Dinosaur>>>((ref) {
  final dinosaurList = ref.read(dinosaurListProvider);
  Map<String, List<Dinosaur>> dinoByCountry = {};
  for (var dino in dinosaurList) {
    if (!dinoByCountry.containsKey(dino.country)) {
      dinoByCountry[dino.country] = [];
    }
    dinoByCountry[dino.country]!.add(dino);
  }
  return dinoByCountry;
});

final selectedCountries =
    StateNotifierProvider<SelectedCountries, Set<Country>>(
        (ref) => SelectedCountries());

class SelectedCountries extends StateNotifier<Set<Country>> {
  SelectedCountries() : super({});

  bool isSelected(Country country) {
    return state.contains(country);
  }

  void select(Country country) {
    if (!state.contains(country)) {
      state = {...state, country};
    }
  }

  void unselect(Country country) {
    if (state.contains(country)) {
      state = state.where((c) => c != country).toSet();
    }
  }
}
