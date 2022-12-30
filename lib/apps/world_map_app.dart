import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map.dart';

void main() {
  runApp(ProviderScope(
    observers: [
      //ProviderMonitor.instance,
    ],
    child: WorldMapApp(),
  ));
}

class WorldMapApp extends StatelessWidget {
  const WorldMapApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClipPath Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('World Map'),
        ),
        body: const WorldMap(
          oscillate: false,
        ),
      ),
    );
  }
}
