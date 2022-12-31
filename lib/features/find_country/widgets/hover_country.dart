import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map.dart';

class HoverCountry extends ConsumerWidget {
  const HoverCountry({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoverCountry = ref.watch(WorldMap.hoverCountry);
    return Text(
      hoverCountry,
      style: const TextStyle(
        color: Colors.blueGrey,
        fontSize: 20,
      ),
    );
  }
}
