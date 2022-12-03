import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:vector_map/vector_map.dart';

class InteractiveWorldMap extends StatefulWidget {
  final void Function(Country country) onPreview;

  const InteractiveWorldMap({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _InteractiveWorldMapState();
}

class _InteractiveWorldMapState extends State<InteractiveWorldMap> {
  VectorMapController? _controller;
  MapDebugger debugger = MapDebugger();

  @override
  void initState() {
    super.initState();
    _loadDataSources();
  }

  void _loadDataSources() async {
    _loadMapLayer().then((layer) {
      setState(() {
        _controller = VectorMapController(
            layers: [layer],
            delayToRefreshResolution: 0,
            minScale: 3,
            maxScale: 100,
            mode: VectorMapMode.panAndZoom);
      });
      debugPrint('Map has been loaded ${_controller.runtimeType}');
      setState(() {});
    }, onError: (error) {
      debugPrint('There was an issue loading map: ${error.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.blue[800]!),
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: _controller == null
                ? const Center(child: Text('Loading...'))
                : VectorMap(
                    controller: _controller,
                    clickListener: (feature) => print(feature.id),
                    hoverListener: (feature) => print(feature?.id ?? -1),
                    color: Colors.lightBlue.shade300,
                  ),
          ),
        ),
      ),
    );
  }

  Future<MapLayer> _loadMapLayer() async {
    String geoJson = Platform.isMacOS
        ? await File(
                '/Users/timmcmaster/Workspace/clone/vector_map_flutter/example/assets/world_countries.json')
            .readAsStringSync()
        : Platform.isIOS
            ? await rootBundle.loadString('assets/world_countries.json')
            : await rootBundle.loadString('assets/world_countries.json');

    MapDataSource ds = await MapDataSource.geoJson(geoJson: geoJson);
    return MapLayer(
      dataSource: ds,
      theme: MapTheme(
        color: Colors.grey.shade100,
      ),
    );
  }
}
