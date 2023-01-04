import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/apps/find_dinosaurs/find_dinosaurs_controller.dart';
import 'package:wt_geography_play/apps/find_dinosaurs/widgets/dinosaur_info_buttons.dart';

class FoundDinosaurList extends ConsumerWidget {
  final FindDinosaursController controller;

  const FoundDinosaurList({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(controller.state);
    final found = state.found.toList();
    found.sort((a, b) => a.compareTo(b));
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DinosaurInfoButtons(
            collected: found,
            controller: controller,
            direction: Axis.horizontal,
          ),
        ],
      ),
    );
  }
}
