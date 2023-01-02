import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/explore_map/models/explore_map_state.dart';

class ExploreMapStateNotifier extends StateNotifier<ExploreMapState> {
  static final log = logger(ExploreMapStateNotifier, level: Level.warning);

  final Ref ref;

  ExploreMapStateNotifier(this.ref) : super(ExploreMapState.empty());

  void select(String country) {
    state = state.copyWith(
      distance: state.distance + 1000,
    );
  }
}
