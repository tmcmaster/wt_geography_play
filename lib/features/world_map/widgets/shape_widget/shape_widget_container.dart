import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';

class ShapeWidgetContainer extends ConsumerWidget {
  static final log = logger(ShapeWidgetContainer, level: Level.warning);

  const ShapeWidgetContainer({
    super.key,
    required this.country,
    required this.color,
    required this.selectedProvider,
  });

  final String country;
  final Color color;
  final AutoDisposeProvider<bool> selectedProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v('Building Widget : $country');
    final selected = ref.watch(selectedProvider);
    return Stack(
      children: [
        Container(
          color: selected ? color : Colors.grey.shade300,
        ),
        Container(
          color: Colors.white.withOpacity(0.5),
        )
      ],
    );
  }
}
