import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vector_map/vector_map.dart';

import '../models/dinosaur.dart';

final dataSourceFutureProvider = FutureProvider(
  (ref) async {
    String geoJson = await rootBundle.loadString('assets/data/world_countries.json');
    return await MapDataSource.geoJson(geoJson: geoJson, labelKey: 'name');
  },
);

final countryColorMapProvider = Provider<Map<String, Color>>(
  (ref) => {
    'Australia': Colors.yellow,
    'USA': Colors.blue,
    'China': Colors.red,
    'Libya': Colors.greenAccent,
    'Canada': Colors.yellow,
    'Syria': Colors.green,
    'Russia': Colors.orangeAccent,
    'Yemen': Colors.redAccent,
    'Botswana': Colors.red,
    'Uruguay': Colors.red,
    'Vietnam': Colors.yellow,
    'Mongolia': Colors.yellow,
    'Bolivia': Colors.blue,
    'Argentina': Colors.green,
    'Greenland': Colors.green
  },
);

final dinosaurListProvider = Provider<List<Dinosaur>>(
  (ref) => [
    Dinosaur(id: '001', name: 'Stegie', country: 'USA'),
    Dinosaur(id: '002', name: 'Apatasaurus', country: 'USA'),
  ],
);

final dinosaurByCountryProvider = Provider<Map<String, List<Dinosaur>>>((ref) {
  final dinosaurList = ref.read(dinosaurListProvider);
  Map<String, List<Dinosaur>> dinoByCountry = {};
  for (var dino in dinosaurList) {
    if (!dinoByCountry.containsKey(dino.country)) {
      dinoByCountry[dino.country] = [];
    }
    dinoByCountry[dino.country]!.add(dino);
  }
  return dinoByCountry;
});

final zoomModeProvider = StateNotifierProvider<ZoomModeNotifier, bool>(
  (ref) => ZoomModeNotifier(),
);

class ZoomModeNotifier extends StateNotifier<bool> {
  ZoomModeNotifier() : super(false);

  void enable(bool enable) {
    if (state != enable) {
      state = enable;
    }
  }

  void toggle() {
    state = !state;
  }
}
