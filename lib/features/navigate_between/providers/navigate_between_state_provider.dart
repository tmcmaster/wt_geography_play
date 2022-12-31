import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/navigate_between/models/navigate_between_state.dart';

final navigateBetweenStateProvider =
    StateNotifierProvider<NavigateBetweenStateNotifier, NavigateBetweenState>(
  name: 'Navigate Between State',
  (ref) => NavigateBetweenStateNotifier(),
);

class NavigateBetweenStateNotifier extends StateNotifier<NavigateBetweenState> {
  NavigateBetweenStateNotifier()
      : super(NavigateBetweenState(
          source: '',
          destination: '',
          selected: '',
        ));

  void setSelected(String selectedCountry) {
    state = state.copyWith(
      selected: selectedCountry,
    );
  }

  void setGoal({
    required String fromCountry,
    required String toCountry,
  }) {
    print('Updating Goal');
    state = state.copyWith(
      source: fromCountry,
      destination: toCountry,
      selected: fromCountry,
    );
  }
}
