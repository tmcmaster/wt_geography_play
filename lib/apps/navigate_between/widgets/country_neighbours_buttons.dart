import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/apps/navigate_between/navigate_between_controller.dart';

class CountryNeighboursButtons extends ConsumerWidget {
  final NavigateBetweenController controller;
  const CountryNeighboursButtons({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(controller.state);

    final selected = ref.read(controller.country(state.selected));
    final neighbours = selected?.neighbours ?? [];
    return Expanded(
      child: state.completed
          ? const Text(
              'Journey Completed!!',
              style: TextStyle(fontSize: 20, color: Colors.blueGrey),
            )
          : ListView(
              scrollDirection: Axis.horizontal,
              children: neighbours.map((neighbour) => controller.select.button(neighbour)).toList(),
            ),
    );
  }
}
