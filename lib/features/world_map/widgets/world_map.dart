import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/world_map/models/world_map_country.dart';
import 'package:wt_geography_play/features/world_map/providers/country_list.dart';
import 'package:wt_geography_play/features/world_map/providers/hover_country.dart';
import 'package:wt_geography_play/features/world_map/providers/selected_countries.dart';
import 'package:wt_geography_play/features/world_map/widgets/shape_widget.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map/world_map_canvas.dart';

class WorldMap extends ConsumerWidget {
  static final log = logger(WorldMap, level: Level.warning);

  static final countryCount = Provider(
    name: 'Country Count',
    (ref) => ref.watch(WorldMap.countryMap).length,
  );

  static final countryMap =
      StateNotifierProvider<CountryListNotifier, Map<String, WorldMapCountry>>(
    name: 'Country List',
    (ref) => CountryListNotifier(),
  );

  static final isSelected = Provider.autoDispose.family<bool, String>(
    name: 'Is Country Selected family',
    (ref, country) {
      return ref.watch(WorldMap.selectedCountries).contains(country);
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

  final void Function(String country)? onSelect;
  final void Function(String country)? onHover;

  const WorldMap({
    super.key,
    this.onSelect,
    this.onHover,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v('Building Widget');
    ref.watch(WorldMap.countryCount);
    List<WorldMapCountry> countryList = ref.read(WorldMap.countryMap).values.toList();
    return FittedBox(
      child: WorldMapCanvas(
        children: fromCountryList(
          countryList,
          shadow: true,
          onSelect: onSelect,
          onHover: onHover,
        ),
      ),
    );
  }

  static List<ShapeWidget> fromCountryList(
    List<WorldMapCountry> countryList, {
    void Function(String country)? onSelect,
    void Function(String country)? onHover,
    bool shadow = false,
    Offset offset = const Offset(0, 0),
  }) {
    return [
      if (shadow) true,
      false,
    ]
        .map((shadowLayer) => countryList
            .map((country) {
              log.v('Creating selection providers for ${country.name}');
              final countrySelectedProvider = WorldMap.isSelected(country.name);
              return country.shapes
                  .map(
                    (shape) => ShapeWidget(
                      offset: offset,
                      country: country.name,
                      scale: 4.3,
                      shape: shape,
                      color: country.color,
                      shadow: shadowLayer,
                      selectedProvider: countrySelectedProvider,
                      onSelect: onSelect,
                      onHover: onHover,
                    ),
                  )
                  .toList();
            })
            .expand((item) => item)
            .toList())
        .expand((e) => e)
        .toList();
  }
}
