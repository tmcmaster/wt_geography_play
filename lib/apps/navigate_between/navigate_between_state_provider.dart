import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/apps/navigate_between/models/navigate_between_state.dart';
import 'package:wt_geography_play/features/world_map/models/world_map_country.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map/world_map_controller.dart';

class NavigateBetweenStateNotifier extends StateNotifier<NavigateBetweenState> {
  static final log = logger(NavigateBetweenStateNotifier, level: Level.warning);

  final Ref ref;

  NavigateBetweenStateNotifier(this.ref) : super(NavigateBetweenState.empty());

  void setSelected(String selectedCountry) {
    if (!state.active) {
      throw Exception('Not currently active.');
    }
    final previousCountry = state.visited.last;
    final distanceTravelled = _calculateDistance(previousCountry, selectedCountry);
    state = state.copyWith(
      selected: selectedCountry,
      visited: [...state.visited, selectedCountry],
      distance: state.distance + distanceTravelled,
    );
  }

  // TODO: may want to move this into the abstract controller
  double _calculateDistance(String from, String to) {
    final WorldMapCountry? fromCountry = ref.read(WorldMapController.countryMap)[from];
    final WorldMapCountry? toCountry = ref.read(WorldMapController.countryMap)[to];
    if (fromCountry == null || toCountry == null) {
      throw Exception('Could not calculate distance between countries: '
          'From(${fromCountry?.name}) -> To(${toCountry?.name})');
    }
    final double fromLat = fromCountry.latitude.toDouble();
    final double fromLng = fromCountry.longitude.toDouble();
    final double toLat = toCountry.latitude.toDouble();
    final double toLng = toCountry.longitude.toDouble();

    if (fromLat != 0 && fromLng != 0 && toLat != 0 && toLng != 0) {
      return Geolocator.distanceBetween(fromLat, fromLng, toLat, toLng);
    } else {
      throw Exception('Missing some location data: '
          'From(${fromCountry.name}) -> To(${toCountry.name})');
    }
  }

  void setGoal({
    required String fromCountry,
    required String toCountry,
  }) {
    log.d('Updating Goal');
    state = NavigateBetweenState.init(
      source: fromCountry,
      destination: toCountry,
    );
  }
}
