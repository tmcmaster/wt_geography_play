import 'dart:ui';

import 'package:wt_geography_play/features/world_map/models/shape.dart';

class WorldMapCountry {
  final String name;
  final Color color;
  final List<Shape> shapes;
  final List<String> neighbours;
  final String capital;
  final String code;
  final String continent;
  final double longitude;
  final double latitude;
  WorldMapCountry({
    required this.name,
    required this.color,
    required this.shapes,
    this.neighbours = const [],
    this.capital = '',
    this.code = '',
    this.continent = '',
    this.longitude = 0.0,
    this.latitude = 0.0,
  });

  @override
  String toString() {
    return 'Country('
        'name: $name, '
        'code: $code, '
        'capital: $capital, '
        'color: $color, '
        'shapes: ${shapes.length}, '
        'longitude: $longitude, '
        'latitude: $latitude, '
        'neighbours: ${neighbours.length})';
  }
}
