import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interactive_world_map/models/country.dart';
import 'package:interactive_world_map/providers/providers.dart';
import 'package:vector_map/vector_map.dart';

import 'interactive_word_map_notifier.dart';

class InteractiveWorldMap extends ConsumerWidget {
  static final selected = StateNotifierProvider<InteractiveWorldMaoNotifier, Set<Country>>(
      (ref) => InteractiveWorldMaoNotifier());

  static final hover = StateProvider<Country?>((ref) => null);

  final void Function(Country?)? onHover;
  final void Function(Country)? onSelect;
  final void Function(Country)? onUnselect;
  final void Function(Set<Country>)? onSelectionChanged;

  final VectorMapMode mode;
  final bool canSelect;

  const InteractiveWorldMap({
    super.key,
    this.onHover,
    this.onSelect,
    this.onUnselect,
    this.onSelectionChanged,
    this.mode = VectorMapMode.autoFit,
    this.canSelect = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryColorMap = ref.read(countryColorMapProvider);
    final mapDataSource = ref.watch(dataSourceFutureProvider);
    final selectedNotifier = ref.read(InteractiveWorldMap.selected.notifier);
    final hoverNotifier = ref.read(InteractiveWorldMap.hover.notifier);
    final modeNotifier = ref.read(zoomModeProvider.notifier);

    return mapDataSource.when(
        data: (mapDataSource) => _InteractiveWorldMap(
              mode: mode,
              canSelect: canSelect,
              countryColorMap: countryColorMap,
              mapDataSource: mapDataSource,
              selectedNotifier: selectedNotifier,
              modeNotifier: modeNotifier,
              onHover: (country) {
                hoverNotifier.state = country;
                onHover?.call(country);
              },
              onSelect: onSelect,
              onUnselect: onUnselect,
              onSelectionChanged: onSelectionChanged,
            ),
        error: (error, _) => Center(child: Text('Error: ${error.toString()}')),
        loading: () => const Center(child: Text('Loading...')));
  }
}

class _InteractiveWorldMap extends StatefulWidget {
  final MapDataSource mapDataSource;
  final Map<String, Color> countryColorMap;
  final void Function(Country?)? onHover;
  final void Function(Country)? onSelect;
  final void Function(Country)? onUnselect;
  final void Function(Set<Country>)? onSelectionChanged;
  final InteractiveWorldMaoNotifier selectedNotifier;
  final ZoomModeNotifier modeNotifier;
  final VectorMapMode mode;
  final bool canSelect;

  const _InteractiveWorldMap({
    required this.mapDataSource,
    required this.selectedNotifier,
    required this.modeNotifier,
    this.countryColorMap = const {},
    this.onHover,
    this.onSelect,
    this.onUnselect,
    this.onSelectionChanged,
    this.mode = VectorMapMode.autoFit,
    this.canSelect = false,
  });

  @override
  State<_InteractiveWorldMap> createState() => _InteractiveWorldMapState();
}

final colors = [
  Colors.red,
  Colors.blue,
  Colors.yellow,
  Colors.blueGrey,
  Colors.amberAccent,
  Colors.deepPurple,
  Colors.orangeAccent,
  Colors.green,
  Colors.amber,
];

class _InteractiveWorldMapState extends State<_InteractiveWorldMap> {
  late VectorMapController controller;
  late RemoveListener _removeListener;
  late RemoveListener _removeListener2;

  @override
  void initState() {
    controller = VectorMapController(
      delayToRefreshResolution: 0,
      minScale: 1,
      maxScale: 100,
      mode: widget.mode,
      layers: [
        MapLayer(
          dataSource: widget.mapDataSource,
          highlightTheme: Platform.isMacOS
              ? MapHighlightTheme(
                  color: Colors.white,
                )
              : null,
          theme: MapRuleTheme(
            color: Colors.grey.shade100,
            contourColor: Colors.grey,
            colorRules: [
              (feature) => _countrySelectColor(feature),
              // (feature) => _countryColor(feature.label),
            ],
          ),
        ),
      ],
    );

    // controller.addListener(() {
    //   debugPrint(controller.scale.toString());
    // });
    //

    _removeListener2 = widget.modeNotifier.addListener((enabled) {
      controller.mode = enabled ? VectorMapMode.panAndZoom : VectorMapMode.autoFit;
    });

    _removeListener = widget.selectedNotifier.addListener((state) {
      controller.notifyPanZoomMode(start: false);
    });

    super.initState();
  }

  @override
  void dispose() {
    _removeListener.call();
    _removeListener2.call();
    super.dispose();
  }

  Color? _countrySelectColor(MapFeature feature) {
    final country = _featureToCountry(feature);
    return widget.selectedNotifier.isSelected(country)
        ? _countryColor(country)
        : Colors.grey.shade200;
  }

  Color _countryColor(Country country) {
    return widget.countryColorMap.containsKey(country.name)
        ? widget.countryColorMap[country.name] ?? Colors.grey.shade600
        : colors[int.parse(country.id) % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return VectorMap(
      controller: controller,
      clickListener: (feature) {
        final country = _featureToCountry(feature);
        if (widget.selectedNotifier.isSelected(country)) {
          if (widget.canSelect) {
            widget.selectedNotifier.unselect(country);
          }
          widget.onUnselect?.call(country);
        } else {
          if (widget.canSelect) {
            widget.selectedNotifier.select(country);
          }
          widget.onSelect?.call(country);
        }
      },
      hoverListener: (feature) {
        final country = feature == null ? null : _featureToCountry(feature);
        widget.onHover?.call(country);
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
