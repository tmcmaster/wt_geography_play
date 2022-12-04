import 'package:flutter/material.dart';
import 'package:vector_map/vector_map.dart';
import 'package:wt_geography_play/src/models/country.dart';

class InteractiveWorldMapController extends VectorMapController {
  final Set<Country> selected;
  final Map<String, Color> countryColorMap;
  final bool enableHover;

  final void Function(Set<Country> selectedCountries)? onSelectionChange;
  final void Function(Country country)? onSelect;
  final void Function(Country country)? onHover;

  InteractiveWorldMapController({
    this.selected = const {},
    this.countryColorMap = const {},
    this.enableHover = true,
    this.onSelectionChange,
    this.onHover,
    this.onSelect,
  }) : super(
          delayToRefreshResolution: 0,
          minScale: 3,
          maxScale: 100,
          mode: VectorMapMode.panAndZoom,
        );

  bool isSelected(Country country) {
    return selected.contains(country);
  }

  void repaint() {
    notifyPanZoomMode(start: false);
  }

  void select(Country country) {
    if (!selected.contains(country)) {
      selected.add(country);
      onSelect?.call(country);
      onSelectionChange?.call(selected);
      repaint();
    }
  }

  void unselect(Country country) {
    if (selected.contains(country)) {
      selected.remove(country);
      onSelectionChange?.call(selected);
      repaint();
    }
  }

  Country _featureToCountry(MapFeature feature) {
    return Country(
      id: feature.id.toString(),
      name: feature.label ?? 'Unknown',
    );
  }
}
