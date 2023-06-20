import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_logging/wt_logging.dart';

class SelectedCountriesNotifier extends StateNotifier<Set<String>> {
  static final log = logger(SelectedCountriesNotifier, level: Level.warning);

  SelectedCountriesNotifier() : super({});

  void select(String country, {bool toggle = true}) {
    if (!state.contains(country)) {
      log.d('Selecting $country');
      state = {...state, country};
    } else if (toggle) {
      log.d('Unselecting $country');
      state = state.where((item) => item != country).toSet();
    }
  }

  void unselect(String country) {
    if (state.contains(country)) {
      state = state.where((item) => item != country).toSet();
    }
  }

  void clear() {
    state = {};
  }
}
