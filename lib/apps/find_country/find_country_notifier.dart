import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/apps/find_country/models/find_country_state.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map/world_map_controller.dart';

class FindCountryStateNotifier extends StateNotifier<FindCountryState> {
  static final random = Random();

  static final log = logger(FindCountryStateNotifier, level: Level.warning);

  final Ref ref;

  FindCountryStateNotifier(this.ref) : super(FindCountryState.empty()) {
    ref.listen(WorldMapController.countryMap, (_, countryMap) {
      final countryList = countryMap.keys.toList();
      setCountryList(countryList);
    });

    final countryMap = ref.read(WorldMapController.countryMap);
    if (countryMap.isNotEmpty) {
      final countryList = countryMap.keys.toList();
      Future.delayed(const Duration(), () {
        setCountryList(countryList);
        reset();
      });
    }
  }

  void update(FindCountryState newState) {
    state = newState;
  }

  void reset() {
    setCountryList(state.countryList);
  }

  void setCountryList(List<String> countryList) {
    if (countryList.isNotEmpty) {
      final initialCountryToFind = _selectCountryToFind(countryList);
      state = FindCountryState.init(
        countryList: countryList,
        initialCountryToFind: initialCountryToFind,
      );
    } else {
      state = FindCountryState.empty();
    }
  }

  void select(String country) {
    if (country == state.countryToFind) {
      final countriesFound = [...state.countriesFound, country];
      final countryToFind = _selectCountryToFind(state.countryList, countriesFound);

      state = state.copyWith(
        countriesFound: countriesFound,
        countryToFind: countryToFind,
      );
    } else {
      state = state.copyWith(
        errors: state.errors + 1,
      );
    }
  }

  void hint() {
    final countriesFound = [...state.countriesFound, state.countryToFind];
    final countryToFind = _selectCountryToFind(state.countryList, countriesFound);

    state = state.copyWith(
      countriesFound: countriesFound,
      countryToFind: countryToFind,
      hints: state.hints + 1,
    );
  }

  static String _selectCountryToFind(List<String> countryList,
      [List<String> countriesFound = const []]) {
    final options = countryList.where((country) => !countriesFound.contains(country)).toList();
    return options[random.nextInt(options.length)];
  }
}
