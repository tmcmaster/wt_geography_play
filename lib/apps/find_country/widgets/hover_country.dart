import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map/world_map_controller.dart';

class HoverCountry extends ConsumerWidget {
  const HoverCountry({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoverCountry = ref.watch(WorldMapController.hoverCountry);
    return Text(
      hoverCountry,
      style: const TextStyle(
        color: Colors.blueGrey,
        fontSize: 20,
      ),
    );
  }
}
