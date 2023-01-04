import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/apps/find_dinosaurs/find_dinosaurs_state_notifier.dart';
import 'package:wt_geography_play/apps/find_dinosaurs/models/dinosaur.dart';
import 'package:wt_geography_play/apps/find_dinosaurs/models/find_dinosaurs_state.dart';
import 'package:wt_geography_play/apps/find_dinosaurs/providers/dinosaur_list.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map/world_map_controller.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_app/world_map_app_action_item.dart';

class FindDinosaursController extends WorldMapController {
  static final log = logger(FindDinosaursController, level: Level.verbose);
  static final random = Random();

  static final provider = Provider((ref) => FindDinosaursController._(ref));

  final state = StateNotifierProvider<FindDinosaursStateNotifier, FindDinosaursState>(
    name: 'Explore Map State',
    (ref) => FindDinosaursStateNotifier(ref),
  );

  static final dinosaurMap = StateNotifierProvider<DinosaurListNotifier, Map<String, Dinosaur>>(
    name: 'Dinosaur List',
    (ref) => DinosaurListNotifier(),
  );

  late WorldMapAppActionItem previewDinosaurButton;

  FindDinosaursController._(super.ref) {
    final notifier = ref.read(state.notifier);
    ref.listen(dinosaurMap, (previous, dinosaurMap) {
      notifier.setTotal(dinosaurMap.length);
      resetTheGame();
    });
    Future.delayed(const Duration(milliseconds: 1), () {
      notifier.setTotal(ref.read(dinosaurMap).length);
    });

    previewDinosaurButton = WorldMapAppActionItem<String>(
        onPressed: (dinosaurName) {
          final dinosaurMap = ref.read(FindDinosaursController.dinosaurMap);
          final dinosaur = dinosaurMap[dinosaurName];
          if (dinosaur != null && dinosaur.link.isNotEmpty) {
            launchUrl(Uri.parse(dinosaur.link));
          }
        },
        getLabel: (item) => item);
  }

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
    final notifier = ref.read(state.notifier);

    final dinosaurs = ref.read(dinosaurMap).values.toList();

    log.d('About to search ${dinosaurs.length} dinosaurs');
    final found = dinosaurs
        .where((dinosaur) {
          return dinosaur.livedIn == country;
        })
        .map((d) => d.name)
        .toList();

    log.d('Found ${found.length} dinosaurs');
    if (dinosaurs.isNotEmpty) {
      notifier.foundDinosaurs(found);
    }
  }

  void resetTheGame() {
    ref.read(selectedCountries.notifier).clear();
    ref.read(state.notifier).reset();
  }
}
