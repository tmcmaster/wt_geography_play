import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorldMapCanvas extends ConsumerWidget {
  final Size size;

  const WorldMapCanvas({
    super.key,
    required this.children,
    this.size = const Size(1600, 800),
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.transparent,
      child: Stack(
        children: [
          ...children,
        ],
      ),
    );
  }
}
