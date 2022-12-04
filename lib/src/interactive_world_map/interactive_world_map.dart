import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vector_map/vector_map.dart';
import 'package:wt_geography_play/src/interactive_world_map/interactive_word_map_notifier.dart';
import 'package:wt_geography_play/src/models/country.dart';

class InteractiveWorldMap extends StatefulWidget {
  static final selected =
      StateNotifierProvider<InteractiveWorkdMaoNotifier, Set<Country>>(
          (ref) => InteractiveWorkdMaoNotifier());

  final MapDataSource mapDataSource;
  final Map<String, Color> countryColorMap;
  final void Function(Country)? onHover;
  final void Function(Country)? onSelect;
  final void Function(Country)? onUnselect;
  final void Function(Set<Country>)? onSelectionChanged;
  final InteractiveWorkdMaoNotifier selectedNotifier;

  const InteractiveWorldMap({
    super.key,
    required this.mapDataSource,
    required this.selectedNotifier,
    this.countryColorMap = const {},
    this.onHover,
    this.onSelect,
    this.onUnselect,
    this.onSelectionChanged,
  });

  @override
  State<InteractiveWorldMap> createState() => _InteractiveWorldMapState();
}

class _InteractiveWorldMapState extends State<InteractiveWorldMap> {
  late VectorMapController controller;
  late RemoveListener _removeListener;

  @override
  void initState() {
    controller = VectorMapController(
      delayToRefreshResolution: 0,
      minScale: 3,
      maxScale: 100,
      mode: VectorMapMode.panAndZoom,
      layers: [
        MapLayer(
          dataSource: widget.mapDataSource,
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
      ],
    );

    _removeListener = widget.selectedNotifier.addListener((state) {
      controller.notifyPanZoomMode(start: false);
    });

    super.initState();
  }

  @override
  void dispose() {
    _removeListener.call();
    super.dispose();
  }

  Color? _countrySelectColor(MapFeature feature) {
    final country = _featureToCountry(feature);
    return widget.selectedNotifier.isSelected(country)
        ? Colors.grey.shade400
        : null;
  }

  Color _countryColor(String? countryName) {
    return widget.countryColorMap.containsKey(countryName)
        ? widget.countryColorMap[countryName] ?? Colors.grey.shade600
        : Colors.grey.shade200;
  }

  @override
  Widget build(BuildContext context) {
    return VectorMap(
      controller: controller,
      clickListener: (feature) {
        final country = _featureToCountry(feature);
        if (widget.selectedNotifier.isSelected(country)) {
          widget.selectedNotifier.unselect(country);
          widget.onUnselect?.call(country);
        } else {
          widget.selectedNotifier.select(country);
          widget.onSelect?.call(country);
        }
      },
      hoverListener: (feature) {
        if (feature != null) {
          final country = _featureToCountry(feature);
          widget.onHover?.call(country);
        }
      },
      hoverRule: (feature) => true,
      color: Colors.lightBlue.shade300,
    );
  }

  Country _featureToCountry(MapFeature feature) {
    return Country(
      id: feature.id.toString(),
      name: feature.label ?? 'Unknown',
    );
  }
}
