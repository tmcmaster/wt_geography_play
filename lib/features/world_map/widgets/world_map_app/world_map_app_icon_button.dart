import 'package:flutter/material.dart';

class WorldMapAppIconButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;

  const WorldMapAppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: Colors.blueGrey,
      ),
      hoverColor: Colors.transparent,
      onPressed: onPressed,
    );
  }
}
