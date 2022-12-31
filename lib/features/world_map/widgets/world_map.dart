import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/world_map/models/country.dart';
import 'package:wt_geography_play/features/world_map/providers/country_list.dart';
import 'package:wt_geography_play/features/world_map/providers/hover_country.dart';
import 'package:wt_geography_play/features/world_map/providers/selected_countries.dart';
import 'package:wt_geography_play/features/world_map/widgets/shape_widget.dart';

class WorldMap extends ConsumerWidget {
  static final log = logger(WorldMap, level: Level.warning);

  static final countryCount = Provider(
    name: 'Country Count',
    (ref) => ref.watch(WorldMap.countryList).length,
  );

  static final countryList = StateNotifierProvider<CountryListNotifier, List<Country>>(
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
    List<Country> countryList = ref.read(WorldMap.countryList);
    return FittedBox(
      child: _MapCanvas(
        children: [true, false]
            .map((shadow) => countryList
                // .where((c) => c.name == 'Egypt')
                .map((country) {
                  log.v('Creating selection providers for ${country.name}');
                  final countrySelectedProvider = WorldMap.isSelected(country.name);
                  return country.shapes
                      .map(
                        (shape) => ShapeWidget(
                          country: country.name,
                          scale: 4.3,
                          shape: shape,
                          color: country.color,
                          shadow: shadow,
                          selectedProvider: countrySelectedProvider,
                          onSelect: onSelect,
                          onHover: onHover,
                        ),
                      )
                      .toList();
                })
                .toList()
                .expand((item) => item)
                .toList())
            .expand((item) => item)
            .toList(),
      ),
    );
  }
}

class _MapCanvas extends ConsumerWidget {
  const _MapCanvas({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 1600,
      height: 800,
      color: Colors.transparent,
      child: Stack(
        children: [
          ...children,
        ],
      ),
    );
  }
}
