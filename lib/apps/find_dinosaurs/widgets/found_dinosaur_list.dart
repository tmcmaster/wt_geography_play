import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/apps/find_dinosaurs/find_dinosaurs_controller.dart';

class FoundDinosaurList extends ConsumerWidget {
  final FindDinosaursController controller;

  const FoundDinosaurList({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(controller.state);
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: state.found
                    .map((dinosaur) => TextButton(
                          onPressed: () {},
                          child: Text(dinosaur),
                        ))
                    .toList()),
          ),
        ],
      ),
    );
  }
}
