import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/apps/find_dinosaurs/models/dinosaur.dart';

class DinosaurListNotifier extends StateNotifier<Map<String, Dinosaur>> {
  DinosaurListNotifier() : super({}) {
    _DinosaurLoader().load().then((dinosaurs) {
      state = dinosaurs;
    });
  }
}

class _DinosaurLoader {
  Future<Map<String, Dinosaur>> load() async {
    final csvString = await rootBundle.loadString('assets/data/dinosaur_data.csv');

    return {for (Dinosaur d in Dinosaur.from.csvListString(csvString)) d.name: d};
  }
}
