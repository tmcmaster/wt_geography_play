import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map.dart';

void main() {
  runApp(const ProviderScope(
    child: WorldMapApp(),
  ));
}

class WorldMapApp extends StatelessWidget {
  const WorldMapApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ClipPath Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: WorldMap(),
    );
  }
}
