import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/world_map_app/world_map_app.dart';

void main() {
  runApp(const ProviderScope(
    child: MaterialApp(
      title: 'World Map App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WorldMapApp(
          zoomControls: false,
        ),
      ),
    ),
  ));
}
