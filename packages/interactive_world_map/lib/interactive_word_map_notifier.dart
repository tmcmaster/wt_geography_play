import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interactive_world_map/models/country.dart';

class InteractiveWorldMaoNotifier extends StateNotifier<Set<Country>> {
  InteractiveWorldMaoNotifier() : super({});

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

  void clear() {
    state = {};
  }
}
