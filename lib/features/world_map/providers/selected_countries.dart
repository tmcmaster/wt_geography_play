import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedCountriesNotifier extends StateNotifier<Set<String>> {
  SelectedCountriesNotifier() : super({});

  void select(String country) {
    if (!state.contains(country)) {
      print('selecting $country');
      state = {...state, country};
    } else {
      print('unselecting $country');
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
