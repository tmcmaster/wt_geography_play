import 'dart:math';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/world_map/models/world_map_country.dart';
import 'package:wt_geography_play/features/world_map/providers/country_list.dart';
import 'package:wt_geography_play/features/world_map/providers/hover_country.dart';
import 'package:wt_geography_play/features/world_map/providers/selected_countries.dart';
import 'package:wt_geography_play/features/world_map/widgets/shape_widget.dart';

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

  static List<ShapeWidget> fromCountryList(
    List<WorldMapCountry> countryList, {
    void Function(String country)? onSelect,
    void Function(String country)? onHover,
    bool shadow = false,
    // AutoLayout autoLayout = AutoLayout.none,
    Offset offset = const Offset(0, 0),
  }) {
    // final adjustment = _calculateLayoutAdjustment(countryList, autoLayout);

    return [
      if (shadow) true,
      false,
    ]
        .map((shadowLayer) => countryList
            .map((country) {
              log.v('Creating selection providers for ${country.name}');
              final countrySelectedProvider = WorldMapController.isSelected(country.name);
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

  static Rectangle<double> calculateCombinedRegion(List<WorldMapCountry> countries) {
    final regions = countries.map((c) => c.shapes.map((s) => s.region)).expand((r) => r).toList();
    return _calculateCombinedRegion(regions);
  }

  static Rectangle<double> _calculateCombinedRegion(List<Rectangle<double>> regions) {
    final points = regions
        .map((r) => [
              Point<double>(r.left, r.top),
              Point<double>(r.left + r.width, r.top + r.height),
            ])
        .expand((p) => p)
        .toList();

    double left = points[0].x;
    double right = points[0].x;
    double top = points[0].y;
    double bottom = points[0].y;
    for (var point in points) {
      if (point.x < left) {
        left = point.x;
      } else if (point.x > right) {
        right = point.x;
      }
      if (point.y < top) {
        top = point.y;
      } else if (point.y > bottom) {
        bottom = point.y;
      }
    }
    return Rectangle(left, top, right - left, bottom - top);
  }
}
