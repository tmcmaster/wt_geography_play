import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/navigate_between/navigate_between_controller.dart';

class NavigateBetweenObjective extends ConsumerWidget {
  final NavigateBetweenController controller;

  const NavigateBetweenObjective({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(controller.state);
    final objective = state.active ? '${state.source} to ${state.destination}' : '';
    return Text(objective,
        style: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 20,
        ));
  }
}
