import 'package:flutter/material.dart';

class WorldMapAppTextButton extends StatelessWidget {
  final String label;
  final TextStyle? style;
  final void Function() onPressed;

  const WorldMapAppTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.blueGrey,
        ).merge(style),
      ),
    );
  }
}
