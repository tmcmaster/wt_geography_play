import 'dart:convert';
import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'geometry.freezed.dart';
part 'geometry.g.dart';

@freezed
class Geometry with _$Geometry {
  Geometry._();

  factory Geometry({
    @JsonKey(
      name: 'points',
      toJson: Geometry.pointToJson,
      fromJson: Geometry.pointFromJson,
    )
    @Default([])
        List<Point<double>> points,
    @JsonKey(
      name: 'geometries',
      fromJson: Geometry.geometryFromJson,
      toJson: Geometry.geometryToJson,
    )
    @Default([])
        List<Geometry> geometries,
  }) = _Geometry;

  static List<Map<String, dynamic>> geometryToJson(List<Geometry> geometries) {
    return geometries.map((Geometry geometry) {
      return {
        'points': json.encode(geometry.points),
        'geometries': json.encode(geometry.geometries),
      };
    }).toList();
  }

  static List<Geometry> geometryFromJson(List<Map<String, dynamic>> list) {
    return list.map((map) => Geometry.fromJson(map)).toList();
  }

  factory Geometry.fromJson(Map<String, dynamic> json) => _$GeometryFromJson(json);

  static List<List<double>> pointToJson(List<Point<double>> points) =>
      points.map((p) => [p.x, p.y]).toList();
  static List<Point<double>> pointFromJson(List<List<double>> list) =>
      list.map((item) => Point<double>(item[0], item[1])).toList();
}
