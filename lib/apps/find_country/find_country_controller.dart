import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/apps/find_country/find_country_notifier.dart';
import 'package:wt_geography_play/apps/find_country/models/find_country_state.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map.dart';
import 'package:wt_geography_play/features/world_map_app/world_map_listener.dart';

class FindCountryController with WorldMapListener {
  static final log = logger(FindCountryController, level: Level.warning);
  static final random = Random();

  static final provider = Provider((ref) => FindCountryController._(ref));

  final Ref ref;

  final state = StateNotifierProvider<FindCountryStateNotifier, FindCountryState>(
    name: 'Find Country State',
    (ref) => FindCountryStateNotifier(ref),
  );

  FindCountryController._(this.ref);

  @override
  void onClear() {
    resetTheGame();
  }

  @override
  void onHover(String country) {
    ref.read(WorldMap.hoverCountry.notifier).set(country);
  }

  @override
  void onSelect(String country) {
    selectCountry(country);
  }

  void selectCountry(String country) {
    log.d('Selecting Country : $country');
    final countryToFind = ref.read(state).countryToFind;
    if (country == countryToFind) {
      ref.read(WorldMap.selectedCountries.notifier).select(country, toggle: false);
      ref.read(state.notifier).select(country);
    }
  }

  void requestHelp() {
    final country = ref.read(state).countryToFind;
    ref.read(WorldMap.selectedCountries.notifier).select(country);
    ref.read(state.notifier).hint();
  }

  void resetTheGame() {
    ref.read(WorldMap.selectedCountries.notifier).clear();
    ref.read(state.notifier).reset();
  }
}