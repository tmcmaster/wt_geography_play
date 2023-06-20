import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/apps/find_dinosaurs/models/find_dinosaurs_state.dart';
import 'package:wt_logging/wt_logging.dart';

class FindDinosaursStateNotifier extends StateNotifier<FindDinosaursState> {
  static final log = logger(FindDinosaursStateNotifier, level: Level.warning);

  final Ref ref;

  FindDinosaursStateNotifier(this.ref) : super(FindDinosaursState.empty());

  void setTotal(int total) {
    print('Setting Total: $total');
    state = state.copyWith(
      total: total,
    );
  }

  void foundDinosaurs(List<String> dinosaurs) {
    print('Found dinosaurs: ${dinosaurs.length}');
    state = state.copyWith(found: {...dinosaurs}, collected: {...state.collected, ...dinosaurs});
  }

  void reset() {
    print('Clearing dinosaurs');
    state = FindDinosaursState.empty();
  }
}
