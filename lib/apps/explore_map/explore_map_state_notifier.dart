import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/apps/explore_map/models/explore_map_state.dart';
import 'package:wt_logging/wt_logging.dart';

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
