import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/navigate_between/models/navigate_between_state.dart';
import 'package:wt_geography_play/features/navigate_between/providers/navigate_between_state_provider.dart';
import 'package:wt_geography_play/features/world_map/models/world_map_country.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map.dart';
import 'package:wt_geography_play/features/world_map_app/widgets/world_map_action.dart';
import 'package:wt_geography_play/features/world_map_app/widgets/world_map_action_item.dart';
import 'package:wt_geography_play/features/world_map_app/world_map_listener.dart';

class NavigateBetweenController with WorldMapListener {
  static final log = logger(NavigateBetweenController, level: Level.warning);
  static final random = Random();

  static final provider = Provider((ref) => NavigateBetweenController._(ref));

  final Ref ref;

  late WorldMapAction reset;
  late WorldMapActionItem<String> select;

  final state = StateNotifierProvider<NavigateBetweenStateNotifier, NavigateBetweenState>(
    name: 'Navigate Between State',
    (ref) => NavigateBetweenStateNotifier(ref),
  );

  final country = Provider.autoDispose.family<WorldMapCountry?, String>((ref, name) {
    return ref.read(WorldMap.countryMap)[name];
  });

  NavigateBetweenController._(this.ref) {
    reset = WorldMapAction(
      icon: Icons.refresh,
      onPressed: resetGame,
    );
    select = WorldMapActionItem<String>(
      onPressed: (country) => selectCountry(country),
      getLabel: (value) => value,
    );

    ref.listen(WorldMap.countryMap, (_, __) {
      resetGame();
    });
  }

  @override
  void onClear() {
    resetGame();
  }

  @override
  void onHover(String country) {
    ref.read(WorldMap.hoverCountry.notifier).set(country);
  }

  @override
  void onSelect(String country) => selectCountry(country);

  void selectCountry(String country) {
    log.d('Selecting Country : $country');
    ref.read(state.notifier).setSelected(country);
    ref.read(WorldMap.selectedCountries.notifier).select(country, toggle: false);
  }

  void resetGame() {
    log.d('Reset game');
    final mapNotifier = ref.read(WorldMap.selectedCountries.notifier);
    final stateNotifier = ref.read(state.notifier);

    mapNotifier.clear();
    final countries = _randomlySelectCountries();
    stateNotifier.setGoal(fromCountry: countries[0], toCountry: countries[1]);
    for (var country in countries) {
      mapNotifier.select(country);
    }
  }

  List<String> _randomlySelectCountries() {
    final countryList = ref.read(WorldMap.countryMap).keys.toList();
    final fromCountry = countryList[random.nextInt(countryList.length)];
    countryList.remove(fromCountry);
    final toCountry = countryList[random.nextInt(countryList.length)];
    return [fromCountry, toCountry];
  }
}
