import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorldMapCanvas extends ConsumerWidget {
  const WorldMapCanvas({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 1600,
      height: 800,
      color: Colors.transparent,
      child: Stack(
        children: [
          ...children,
        ],
      ),
    );
  }
}
