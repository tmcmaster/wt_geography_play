import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/world_map/models/geometry.dart';

final countryGeometryMapFutureProvider = FutureProvider<Map<String, List<Geometry>>>(
  (ref) async {
    String geoJson = await rootBundle.loadString('assets/data/world_countries.json');
    final geoJsonMap = json.decode(geoJson);

    return CountryGeometriesDecoder().decode(geoJsonMap);
  },
);

class CountryGeometriesDecoder {
  Map<String, List<Geometry>> decode(dynamic geoJsonMap) {
    return {
      for (var feature in geoJsonMap['features'] as List)
        feature['properties']['name'].toString():
            flattenGeometries(convertToGeometryList(feature['geometry']['coordinates']))
    };
  }

  List<Geometry> flattenGeometries(List<Geometry> geometries) {
    return geometries
        .map((geometry) {
          if (geometry.points.isNotEmpty) {
            return [geometry];
          } else {
            return flattenGeometries(geometry.geometries);
          }
        })
        .expand((list) => list)
        .toList();
  }

  List<Geometry> convertToGeometryList(List<dynamic> something) {
    return something.map((s) {
      final item = convertSomething(s);
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

  dynamic convertSomething(dynamic something) {
    if (something is List) {
      if (something.isEmpty) {
        return Geometry();
      } else if (something.length == 2 && something[0] is double) {
        return Point<double>(
          (something[0] as num).toDouble() + 180,
          (something[1] as num).toDouble() * -1 + 90,
        );
      } else {
        final items = something.map((i) => convertSomething(i)).toList();
        return Geometry(
          points: items.whereType<Point<double>>().toList(),
          geometries: items.whereType<Geometry>().toList(),
        );
      }
    } else {
      return Geometry();
    }
  }

  Point<double> convertToPoint(List<double> coordinates) {
    return Point<double>(coordinates[0], coordinates[1]);
  }
}
