import 'dart:math';
import 'dart:ui';

class Shape {
  late List<Point<double>> points;
  late Rectangle<double> region;

  Shape._(List<Point<double>> globalPoints) {
    if (globalPoints.isEmpty) {
      points = const [];
      region = const Rectangle<double>(0, 0, 0, 0);
    } else {
      double left = globalPoints[0].x;
      double right = globalPoints[0].x;
      double top = globalPoints[0].y;
      double bottom = globalPoints[0].y;
      for (var point in globalPoints) {
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
      points = globalPoints.map((p) => Point<double>(p.x - left, p.y - top)).toList();
      region = Rectangle<double>(left, top, right - left, bottom - top);
    }
  }

  Offset get offset => Offset(region.left, region.top);
  Size get size => Size(region.width, region.height);

  factory Shape.fromCoordinates(List<List<double>> coordinates) {
    final points = coordinates.map((c) => Point<double>(c[0], -c[1])).toList();
    return Shape._(points);
  }

  factory Shape.fromPoints(List<Point<double>> points) {
    return Shape._(points);
  }

  int compareTo(Shape other) {
    final distA = sqrt(
      region.top * region.top + region.left * region.left,
    ).toInt();
    final distB = sqrt(
      other.region.top * other.region.top + other.region.left * other.region.left,
    ).toInt();
    return distA - distB;
  }
}
