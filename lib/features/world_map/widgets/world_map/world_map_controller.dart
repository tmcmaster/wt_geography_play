import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/map_data/providers/country_list.dart';
import 'package:wt_geography_play/features/world_map/models/shape.dart';
import 'package:wt_geography_play/features/world_map/models/world_map_country.dart';
import 'package:wt_geography_play/features/world_map/providers/hover_country.dart';
import 'package:wt_geography_play/features/world_map/providers/selected_countries.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_shadow/world_map_shadow.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_shape/world_map_shape..dart';

abstract class WorldMapController {
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

  late AutoDisposeProviderFamily<bool, String> isSelected;

  late StateNotifierProvider<SelectedCountriesNotifier, Set<String>> selectedCountries;

  static final hoverCountry = StateNotifierProvider<HoverCountryNotifier, String>(
    name: 'Hover Country',
    (ref) => HoverCountryNotifier(),
  );

  WorldMapController() {
    selectedCountries = StateNotifierProvider<SelectedCountriesNotifier, Set<String>>(
      name: 'Selected Countries',
      (ref) => SelectedCountriesNotifier(),
    );

    isSelected = Provider.autoDispose.family<bool, String>(
      name: 'Is Country Selected family',
      (ref, country) {
        return ref.watch(selectedCountries).contains(country);
      },
    );
  }

  List<WorldMapShape> fromCountryList(List<WorldMapCountry> countryList) {
    final countryWidgets = countryList
        .map((country) => country.shapes
            .map((shape) => WorldMapShape(
                  country: country.name,
                  shape: shape,
                  controller: this,
                ))
            .toList())
        .expand((element) => element)
        .toList();

    return countryWidgets;
  }

  List<Widget> countriesToWidgets(
    List<WorldMapCountry> countryList, {
    Offset offset = const Offset(0, 0),
    double scale = 4.3,
    Offset shadowOffset = const Offset(0, 0),
  }) {
    final region = WorldMapController.countiesToRegion(countryList);
    final regionalOffset = Offset(-region.left, -region.top);

    return [
      if (shadowOffset.dx != 0 || shadowOffset.dy != 0)
        WorldMapShadow(
          countries: countryList,
          scale: scale,
          offset: shadowOffset,
        ),
      ...countryList
          .map((country) {
            log.v('Creating selection providers for ${country.name}');
            final countrySelectedProvider = isSelected(country.name);
            return country.shapes
                .map(
                  (shape) => WorldMapShape(
                    country: country.name,
                    offset: regionalOffset,
                    scale: scale,
                    shape: shape,
                    color: country.color,
                    controller: this,
                    // shadow: false,
                    // selectedProvider: countrySelectedProvider,
                    // onSelect: onSelect,
                    // onHover: onHover,
                  ),
                )
                .toList();
          })
          .expand((item) => item)
          .toList(),
    ];
  }

  static Path countriesToPath(List<WorldMapCountry> countries, {double scale = 4.3}) {
    final shapes = countriesToShapes(countries);
    return shapesToPath(shapes, scale: scale);
  }

  static Path shapesToPath(List<Shape> shapes, {double scale = 4.3}) {
    final region = regionsToRegion(shapes.map((s) => s.region).toList());
    print('Converting ${shapes.length} into a path');
    Path path = Path();
    for (Shape shape in shapes) {
      if (shape.points.isNotEmpty) {
        print('Moving to point(${shape.points[0].x * scale}, ${shape.points[0].y * scale})');

        final point = Point(
          (shape.points[0].x + shape.region.left - region.left) * scale,
          (shape.points[0].y + shape.region.top - region.top) * scale,
        );

        path.moveTo(point.x, point.y);
        for (var i = 1; i < shape.points.length; i++) {
          final point = Point(
            (shape.points[i].x + shape.region.left - region.left) * scale,
            (shape.points[i].y + shape.region.top - region.top) * scale,
          );
          path.lineTo(point.x, point.y);
        }
        // TODO: review if a close path is needed here.
      }
    }
    return path;
  }

  static Rectangle<double> countiesToRegion(List<WorldMapCountry> countries) {
    final regions = countries.map((c) => c.shapes.map((s) => s.region)).expand((r) => r).toList();
    return regionsToRegion(regions);
  }

  static List<Shape> countriesToShapes(List<WorldMapCountry> countries) {
    return countries.map((c) => c.shapes).expand((s) => s).toList();
  }

  static Rectangle<double> shapesToRegion(List<Shape> shapes) {
    final regions = shapes.map((shape) => shape.region).toList();
    return regionsToRegion(regions);
  }

  static Rectangle<double> regionsToRegion(List<Rectangle<double>> regions) {
    final points = regions
        .map((r) => [
              Point<double>(r.left, r.top),
              Point<double>(r.left + r.width, r.top + r.height),
            ])
        .expand((p) => p)
        .toList();

    if (points.isEmpty) {
      return const Rectangle(0, 0, 0, 0);
    }

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

  void onSelect(String country);
  void onHover(String country);
  void onClear();
}
