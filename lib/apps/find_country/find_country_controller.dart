import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/apps/find_country/find_country_notifier.dart';
import 'package:wt_geography_play/apps/find_country/models/find_country_state.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map/world_map_controller.dart';

class FindCountryController extends WorldMapController {
  static final log = logger(FindCountryController, level: Level.warning);
  static final random = Random();

  static final provider = Provider((ref) => FindCountryController._(ref));

  final state = StateNotifierProvider<FindCountryStateNotifier, FindCountryState>(
    name: 'Find Country State',
    (ref) => FindCountryStateNotifier(ref),
  );

  FindCountryController._(super.ref);

  @override
  void onClear() {
    resetTheGame();
  }

  @override
  void onHover(String country) {
    ref.read(WorldMapController.hoverCountry.notifier).set(country);
  }

  @override
  void onSelect(String country) {
    selectCountry(country);
  }

  void selectCountry(String country) {
    log.d('Selecting Country : $country');
    final countryToFind = ref.read(state).countryToFind;
    ref.read(state.notifier).select(country);
    if (country == countryToFind) {
      ref.read(selectedCountries.notifier).select(country, toggle: false);
    }
  }

  void requestHelp() {
    final country = ref.read(state).countryToFind;
    ref.read(selectedCountries.notifier).select(country);
    ref.read(state.notifier).hint();
  }

  void resetTheGame() {
    ref.read(selectedCountries.notifier).clear();
    ref.read(state.notifier).reset();
  }
}
