import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/apps/explore_map/explore_map_state_notifier.dart';
import 'package:wt_geography_play/apps/explore_map/models/explore_map_state.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map/world_map_controller.dart';

class ExploreMapController extends WorldMapController {
  static final log = logger(ExploreMapController, level: Level.warning);
  static final random = Random();

  static final provider = Provider((ref) => ExploreMapController._(ref));

  final state = StateNotifierProvider<ExploreMapStateNotifier, ExploreMapState>(
    name: 'Explore Map State',
    (ref) => ExploreMapStateNotifier(ref),
  );

  ExploreMapController._(super.ref);

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
    ref.read(selectedCountries.notifier).select(country);
    ref.read(state.notifier).select(country);
  }

  void resetTheGame() {
    ref.read(selectedCountries.notifier).clear();
  }
}
