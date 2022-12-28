import 'package:flutter_riverpod/flutter_riverpod.dart';

final isCountrySelected = Provider.family<bool, String>((ref, country) {
  return ref.watch(selectedCountriesProvider).contains(country);
});

final selectedCountriesProvider = StateNotifierProvider<SelectedCountriesNotifier, Set<String>>(
  name: 'Selected Countries',
  (ref) => SelectedCountriesNotifier(),
);

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
}
