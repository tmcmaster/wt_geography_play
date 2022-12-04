import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/src/models/country.dart';

class InteractiveWorkdMaoNotifier extends StateNotifier<Set<Country>> {
  InteractiveWorkdMaoNotifier() : super({Country(id: '154', name: 'Chad')});

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
