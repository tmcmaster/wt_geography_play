import 'package:flutter/material.dart';
import 'package:wt_geography_play/features/world_map_app/widgets/world_map_icon_button.dart';

class WorldMapAction {
  final IconData icon;
  final void Function() onPressed;
  WorldMapAction({
    required this.icon,
    required this.onPressed,
  });

  Widget button() {
    return WorldMapIconButton(
      icon: icon,
      onPressed: onPressed,
    );
  }
}
