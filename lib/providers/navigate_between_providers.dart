import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/interactive_world_map/interactive_world_map.dart';
import 'package:wt_geography_play/models/country.dart';
import 'package:wt_geography_play/providers/country_list.dart';
import 'package:wt_geography_play/providers/country_neighbours.dart';

final navigateBetweenProvider =
    StateNotifierProvider<NavigateBetweenNotifier, NavigateBetween>(
  (ref) => NavigateBetweenNotifier(ref),
);

class NavigateBetweenNotifier extends StateNotifier<NavigateBetween> {
  static final random = Random();

  final Ref ref;

  NavigateBetweenNotifier(this.ref) : super(NavigateBetween());

  void reset([Country? country]) {
    final notifier = ref.read(InteractiveWorldMap.selected.notifier);
    notifier.clear();
    debugPrint('Resetting');
    final newState = _createNewInitialState(country);
    notifier.select(newState.startCountry!);
    notifier.select(newState.destinationCountry!);
    debugPrint(newState.toString());
    state = newState;
  }

  void select(Country country) {
    final notifier = ref.read(InteractiveWorldMap.selected.notifier);
    notifier.select(country);

    final newTraversalCountries = {...state.traversedCountries, country};

    final countryOptions = _createNextCountryOptions(
      currentCountry: country,
      traversedCountries: newTraversalCountries,
    );

    final newState = NavigateBetween(
      startCountry: state.startCountry,
      destinationCountry: state.destinationCountry,
      currentCountry: country,
      countryOptions: countryOptions,
      traversedCountries: newTraversalCountries,
    );

    state = newState;
  }

  NavigateBetween _createNewInitialState([Country? country]) {
    final countryList = ref.read(countryListProvider);
    final startCountry =
        country ?? countryList[random.nextInt(countryList.length)];
    final destinationCountry = countryList[random.nextInt(countryList.length)];
    final currentCountry = startCountry;
    final traversalCountries = {currentCountry};

    final countryOptions = _createNextCountryOptions(
      currentCountry: currentCountry,
      traversedCountries: traversalCountries,
    );

    return NavigateBetween(
      startCountry: startCountry,
      destinationCountry: destinationCountry,
      currentCountry: currentCountry,
      countryOptions: countryOptions,
      traversedCountries: traversalCountries,
    );
  }

  Set<Country> _createNextCountryOptions({
    required Country currentCountry,
    required Set<Country> traversedCountries,
  }) {
    final countryList = ref.read(countryListProvider);
    final nameToCountryMap = ref.read(nameToCountryMapProvider);
    final neighbourMap = ref.read(countryNeighboursProvider);

    final options = <Country>{};

    final List<Country> neighbours =
        _getNeighbours(currentCountry, neighbourMap, nameToCountryMap);

    // debugPrint('currentCountry: $currentCountry');
    // debugPrint(neighbours.toString());

    int tries = 10;
    while (options.length < 5 && --tries > 0) {
      // final country = countryList[random.nextInt(countryList.length)];
      // if (!traversedCountries.contains(country) && !options.contains(country)) {
      //   options.add(country);
      // }

      if (neighbours.isNotEmpty) {
        final country = neighbours[random.nextInt(neighbours.length)];
        if (!traversedCountries.contains(country) &&
            !options.contains(country)) {
          options.add(country);
        }
      }
    }

    return options;
  }

  List<Country> _getNeighbours(
      Country country,
      Map<String, List<String>> neighbourMap,
      Map<String, Country> nameToCountryMap) {
    final neighbourNames = neighbourMap[country.name] ?? [];

    return neighbourNames
        .map((name) => nameToCountryMap[name])
        .whereType<Country>()
        .toList();
  }
}

class NavigateBetween {
  final Country? startCountry;
  final Country? destinationCountry;
  final Country? currentCountry;
  final Set<Country> traversedCountries;
  final Set<Country> countryOptions;

  NavigateBetween({
    this.startCountry,
    this.destinationCountry,
    this.currentCountry,
    this.traversedCountries = const {},
    this.countryOptions = const {},
  });

  String toString() {
    return 'NavigateBetween(startCountry: $startCountry, destinationCountry: $destinationCountry, countryOptions: $countryOptions)';
  }
}