import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/map_data/models/geometry.dart';
import 'package:wt_geography_play/features/world_map/models/shape.dart';
import 'package:wt_geography_play/features/world_map/models/world_map_country.dart';

class CountryListNotifier extends StateNotifier<Map<String, WorldMapCountry>> {
  static final colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orangeAccent,
  ]
      .map((color) =>
          // TODO: need to update: HSLColor.fromColor(color).withLightness(0.1);
          [for (var i = 100; i < 1000; i += 100) i].map((shade) => color[shade]).toList())
      .expand((element) => element)
      .where((color) => color != null)
      .toList();

  CountryListNotifier() : super({}) {
    _CountryListLoader().load().then((countries) {
      state = countries;
    });
  }
}

class _CountryListLoader {
  static final colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orangeAccent,
  ]
      .map((color) =>
          [for (var i = 100; i < 1000; i += 100) i].map((shade) => color[shade]).toList())
      .expand((element) => element)
      .where((color) => color != null)
      .toList();

  Future<Map<String, WorldMapCountry>> load() async {
    final countryGeometryMap = await _loadCountryGeometriesMap();
    final neighbourMap = await _loadNeighbourMap();
    final countryDetailsMap = await _loadCountryDetails();

    final countryList = countryGeometryMap.keys.map((country) {
      final shapes = countryGeometryMap[country]!.map((g) => Shape.fromPoints(g.points)).toList();
      final int locationID = (shapes[0].region.top * shapes[0].region.left * 1000).toInt();
      final int colorID = locationID % colors.length;
      final color = colors[colorID] ?? Colors.grey;
      final countryDetails = countryDetailsMap[country];
      return WorldMapCountry(
        name: country,
        color: color,
        shapes: shapes,
        neighbours: neighbourMap[country] ?? [],
        code: countryDetails?['code'] ?? '',
        capital: countryDetails?['capital'] ?? '',
        continent: countryDetails?['continent'] ?? '',
        longitude: (countryDetails?['longitude'] ?? 0).toDouble(),
        latitude: (countryDetails?['latitude'] ?? 0).toDouble(),
      );
    }).toList();

    return {for (WorldMapCountry country in countryList) country.name: country};
  }

  Future<Map<String, List<Geometry>>> _loadCountryGeometriesMap() async {
    final geoJson = await rootBundle.loadString('assets/data/world_countries.json');
    final geoJsonMap = json.decode(geoJson);

    final countryGeometryMap = {
      for (var feature in geoJsonMap['features'] as List)
        feature['properties']['name'].toString():
            _flattenGeometries(_convertToGeometryList(feature['geometry']['coordinates']))
    };
    return countryGeometryMap;
  }

  List<Geometry> _flattenGeometries(List<Geometry> geometries) {
    return geometries
        .map((geometry) {
          if (geometry.points.isNotEmpty) {
            return [geometry];
          } else {
            return _flattenGeometries(geometry.geometries);
          }
        })
        .expand((list) => list)
        .toList();
  }

  List<Geometry> _convertToGeometryList(List<dynamic> something) {
    return something.map((s) {
      final item = _convertSomething(s);
      final points = <Point<double>>[];
      final geometries = <Geometry>[];
      if (item is Point<double>) {
        points.add(item);
      } else if (item is Geometry) {
        geometries.add(item);
      }
      return Geometry(
        points: points,
        geometries: geometries,
      );
    }).toList();
  }

  dynamic _convertSomething(dynamic something) {
    if (something is List) {
      if (something.isEmpty) {
        return Geometry();
      } else if (something.length == 2 && something[0] is double) {
        return Point<double>(
          (something[0] as num).toDouble() + 180,
          (something[1] as num).toDouble() * -1 + 90,
        );
      } else {
        final items = something.map((i) => _convertSomething(i)).toList();
        return Geometry(
          points: items.whereType<Point<double>>().toList(),
          geometries: items.whereType<Geometry>().toList(),
        );
      }
    } else {
      return Geometry();
    }
  }

  Future<Map<String, List<String>>> _loadNeighbourMap() async {
    final neighbourMapJson = await rootBundle.loadString('assets/data/country_neighbours.json');
    final neighbourMap = json.decode(neighbourMapJson) as Map;

    return {
      for (String country in neighbourMap.keys)
        country.toString(): (neighbourMap[country] as List).map((c) => c.toString()).toList(),
    };
  }

  Future<Map<String, Map<String, dynamic>>> _loadCountryDetails() async {
    final detailsListJson = await rootBundle.loadString('assets/data/countries.json');
    final detailsList = json.decode(detailsListJson) as List;
    final mapEntries = detailsList.map((details) => _createMapEntry(details)).toList();
    return Map.fromEntries(mapEntries);
  }

  MapEntry<String, Map<String, dynamic>> _createMapEntry(Map<dynamic, dynamic> map) {
    final countryName = map['name'] ?? 'Unknown';
    final details = {
      for (String key in ['capital', 'code', 'continent', 'longitude', 'latitude']) key: map[key]
    };
    return MapEntry(countryName, details);
  }
}
