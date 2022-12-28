import 'dart:ui';

import 'package:wt_geography_play/features/world_map/models/shape.dart';

class Country {
  final String name;
  final Color color;
  final List<Shape> shapes;

  Country({
    required this.name,
    required this.color,
    required this.shapes,
  });
}
