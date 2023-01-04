import 'package:flutter/material.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_app/world_map_app_icon_button.dart';

class WorldMapAppAction {
  final IconData icon;
  final void Function() onPressed;
  WorldMapAppAction({
    required this.icon,
    required this.onPressed,
  });

  Widget button() {
    return WorldMapAppIconButton(
      icon: icon,
      onPressed: onPressed,
    );
  }
}
