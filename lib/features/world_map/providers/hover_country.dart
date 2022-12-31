import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/common/debounce.dart';

class HoverCountryNotifier extends StateNotifier<String> {
  static final log = logger(HoverCountryNotifier, level: Level.warning);

  HoverCountryNotifier() : super('');

  static final _debounce = Debounce(duration: const Duration(seconds: 3));

  void set(String country) {
    if (country.isNotEmpty && state != country) {
      state = country;
      _debounce.run(() {
        log.v('Clearing Hover');
        state = '';
      });
    }
  }

  void clear() {
    if (state.isNotEmpty) {
      state = '';
    }
  }
}
