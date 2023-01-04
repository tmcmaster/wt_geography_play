import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/apps/navigate_between/models/navigate_between_state.dart';
import 'package:wt_geography_play/apps/navigate_between/navigate_between_state_provider.dart';
import 'package:wt_geography_play/features/world_map/models/world_map_country.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map/world_map_controller.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_app/world_map_app_action.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_app/world_map_app_action_item.dart';

class NavigateBetweenController extends WorldMapController {
  static final log = logger(NavigateBetweenController, level: Level.warning);
  static final random = Random();

  static final provider = Provider((ref) => NavigateBetweenController._(ref));

  late WorldMapAppAction reset;
  late WorldMapAppActionItem<String> select;

  final state = StateNotifierProvider<NavigateBetweenStateNotifier, NavigateBetweenState>(
    name: 'Navigate Between State',
    (ref) => NavigateBetweenStateNotifier(ref),
  );

  final country = Provider.autoDispose.family<WorldMapCountry?, String>((ref, name) {
    return ref.read(WorldMapController.countryMap)[name];
  });

  NavigateBetweenController._(super.ref) {
    reset = WorldMapAppAction(
      icon: Icons.refresh,
      onPressed: resetGame,
    );
    select = WorldMapAppActionItem<String>(
      onPressed: (country) => selectCountry(country),
      getLabel: (value) => value,
    );

    ref.listen(WorldMapController.countryMap, (_, __) {
      resetGame();
    });
  }

  @override
  void onClear() {
    resetGame();
  }

  @override
  void onHover(String country) {
    ref.read(WorldMapController.hoverCountry.notifier).set(country);
  }

  @override
  void onSelect(String country) => () {};

  void selectCountry(String country) {
    log.d('Selecting Country : $country');
    ref.read(state.notifier).setSelected(country);
    ref.read(selectedCountries.notifier).select(country, toggle: false);
  }

  void resetGame() {
    log.d('Reset game');
    final mapNotifier = ref.read(selectedCountries.notifier);
    final stateNotifier = ref.read(state.notifier);

    mapNotifier.clear();
    final countries = _randomlySelectCountries();
    stateNotifier.setGoal(fromCountry: countries[0], toCountry: countries[1]);
    for (var country in countries) {
      mapNotifier.select(country);
    }
  }

  List<String> _randomlySelectCountries() {
    final countryList = ref.read(WorldMapController.countryMap).keys.toList();
    final fromCountry = countryList[random.nextInt(countryList.length)];
    countryList.remove(fromCountry);
    final toCountry = countryList[random.nextInt(countryList.length)];
    return [fromCountry, toCountry];
  }
}
