import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_map/vector_map.dart';
import 'package:wt_geography_play/src/interactive_world_map_controller.dart';
import 'package:wt_geography_play/src/models/country.dart';

class InteractiveWorldMap extends StatelessWidget {
  final InteractiveWorldMapController controller;
  final Map<String, Color> countryColorMap;

  InteractiveWorldMap({
    super.key,
    this.countryColorMap = const {},
    required this.controller,
  }) {
    rootBundle.loadString('assets/world_countries.json').then((geoJson) {
      return MapDataSource.geoJson(geoJson: geoJson, labelKey: 'name');
    }).then((mapDataSource) {
      controller.addLayer(
        MapLayer(
          dataSource: mapDataSource,
          highlightTheme: MapHighlightTheme(
            color: Colors.grey.shade400,
          ),
          theme: MapRuleTheme(
            color: Colors.grey.shade100,
            contourColor: Colors.grey,
            colorRules: [
              (feature) => _countrySelectColor(feature),
              (feature) => _countryColor(feature.label),
            ],
          ),
        ),
      );
    });
  }

  Color? _countrySelectColor(MapFeature feature) {
    final country = _featureToCountry(feature);
    return controller.isSelected(country) ? Colors.grey.shade400 : null;
  }

  Color _countryColor(String? countryName) {
    return countryColorMap.containsKey(countryName)
        ? countryColorMap[countryName] ?? Colors.grey.shade600
        : Colors.grey.shade200;
  }

  @override
  Widget build(BuildContext context) {
    return VectorMap(
      controller: controller,
      clickListener: _onSelect,
      hoverListener: _onHover,
      hoverRule: (feature) => controller.enableHover,
      color: Colors.lightBlue.shade300,
    );
  }

  void _onHover(MapFeature? feature) {
    if (feature != null) {
      final country = _featureToCountry(feature);
      controller.onHover?.call(country);
    }
  }

  void _onSelect(MapFeature feature) {
    final country = _featureToCountry(feature);
    controller.onSelect?.call(country);

    if (controller.isSelected(country)) {
      controller.unselect(country);
    } else {
      controller.select(country);
    }
  }

  Country _featureToCountry(MapFeature feature) {
    return Country(
      id: feature.id.toString(),
      name: feature.label ?? 'Unknown',
    );
  }
}
