import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/world_map/models/country.dart';
import 'package:wt_geography_play/features/world_map/models/geometry.dart';
import 'package:wt_geography_play/features/world_map/models/shape.dart';

final countryCountProvider3 = Provider((ref) => ref.watch(countryListProvider3).length);

final countryListProvider3 = StateNotifierProvider<CountryListNotifier, List<Country>>(
  name: 'Country List',
  (ref) => CountryListNotifier(),
);

class CountryListNotifier extends StateNotifier<List<Country>> {
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

  CountryListNotifier() : super([]) {
    rootBundle.loadString('assets/world_countries.json').then((geoJson) {
      final geoJsonMap = json.decode(geoJson);
      final countryGeometryMap = {
        for (var feature in geoJsonMap['features'] as List)
          feature['properties']['name'].toString():
              _flattenGeometries(_convertToGeometryList(feature['geometry']['coordinates']))
      };

      state = countryGeometryMap.keys.map((country) {
        final shapes = countryGeometryMap[country]!.map((g) => Shape(g.points)).toList();
        final int locationID = (shapes[0].region.top * shapes[0].region.left * 1000).toInt();
        final int colorID = locationID % colors.length;
        final color = colors[colorID] ?? Colors.grey;
        return Country(name: country, color: color, shapes: shapes);
      }).toList();
    }, onError: (error) => print(error));
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
}
