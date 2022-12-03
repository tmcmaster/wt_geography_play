import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';
import 'package:wt_geography_play/src/models/country.dart';

// ignore: must_be_immutable
class InteractiveWorldMap extends StatelessWidget {
  final Map<String, Color> countryColorMap;
  final MapDataSource mapDataSource;

  final void Function(Set<Country> selectedCountries)? onSelectionChange;
  final void Function(Country country)? onSelect;
  final void Function(Country country)? onHover;

  final bool enableHover;

  late VectorMapController _controller;

  final Set<Country> _selected = {};

  InteractiveWorldMap({
    super.key,
    required this.mapDataSource,
    this.countryColorMap = const {},
    this.onSelect,
    this.onHover,
    this.onSelectionChange,
    this.enableHover = true,
  }) {
    _controller = VectorMapController(
        layers: [
          MapLayer(
            dataSource: mapDataSource,
            highlightTheme: MapHighlightTheme(color: Colors.grey.shade400),
            theme: MapRuleTheme(
              color: Colors.grey.shade100,
              contourColor: Colors.grey,
              colorRules: [
                (feature) => _selected.contains(_featureToCountry(feature))
                    ? Colors.grey.shade400
                    : null,
                (feature) => countryColorMap.containsKey(feature.label)
                    ? countryColorMap[feature.label] ?? Colors.grey.shade600
                    : Colors.grey.shade200,
              ],
            ),
          )
        ],
        delayToRefreshResolution: 0,
        minScale: 3,
        maxScale: 100,
        mode: VectorMapMode.panAndZoom);
  }

  @override
  Widget build(BuildContext context) {
    return VectorMap(
      controller: _controller,
      clickListener: _onSelect,
      hoverListener: _onHover,
      hoverRule: (feature) => enableHover,
      color: Colors.lightBlue.shade300,
    );
  }

  void _onHover(MapFeature? feature) {
    if (feature != null) {
      final country = _featureToCountry(feature);
      onHover?.call(country);
    }
  }

  void _onSelect(MapFeature feature) {
    final country = _featureToCountry(feature);
    onSelect?.call(country);

    if (_selected.contains(country)) {
      _selected.remove(country);
    } else {
      _selected.add(country);
    }

    // trigger the map to repaint, to reveal the change in selection
    // _controller.notifyPanZoomMode(start: false);
    _controller.fit();
  }

  Country _featureToCountry(MapFeature feature) {
    return Country(
      id: feature.id.toString(),
      name: feature.label ?? 'Unknown',
    );
  }
}
