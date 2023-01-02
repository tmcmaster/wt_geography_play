import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/world_map/models/world_map_country.dart';
import 'package:wt_geography_play/features/world_map/providers/country_list.dart';
import 'package:wt_geography_play/features/world_map/providers/hover_country.dart';
import 'package:wt_geography_play/features/world_map/providers/selected_countries.dart';

class WorldMapController {
  static final log = logger(WorldMapController, level: Level.warning);

  static final countryCount = Provider(
    name: 'Country Count',
    (ref) => ref.watch(WorldMapController.countryMap).length,
  );

  static final countryMap =
      StateNotifierProvider<CountryListNotifier, Map<String, WorldMapCountry>>(
    name: 'Country List',
    (ref) => CountryListNotifier(),
  );

  static final isSelected = Provider.autoDispose.family<bool, String>(
    name: 'Is Country Selected family',
    (ref, country) {
      return ref.watch(WorldMapController.selectedCountries).contains(country);
    },
  );

  static final selectedCountries = StateNotifierProvider<SelectedCountriesNotifier, Set<String>>(
    name: 'Selected Countries',
    (ref) => SelectedCountriesNotifier(),
  );

  static final hoverCountry = StateNotifierProvider<HoverCountryNotifier, String>(
    name: 'Hover Country',
    (ref) => HoverCountryNotifier(),
  );
}
