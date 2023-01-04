import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/apps/find_dinosaurs/find_dinosaurs_controller.dart';
import 'package:wt_geography_play/apps/find_dinosaurs/widgets/dinosaur_info_buttons.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_app/world_map_app_info_panel.dart';

class DinosaurCollection extends ConsumerWidget {
  final FindDinosaursController controller;

  const DinosaurCollection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(controller.state);
    final collected = state.collected.toList();
    collected.sort((a, b) => a.compareTo(b));
    return WorldMapAppInfoPanel(
      size: const Size(400, 400),
      title: 'Dinosaur Collection',
      alignment: Alignment.centerRight,
      children: [
        DinosaurInfoButtons(
          collected: collected,
          controller: controller,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
