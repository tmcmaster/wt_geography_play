import 'package:flutter/material.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_app/world_map_app_text_button.dart';

class WorldMapAppActionItem<T> {
  final void Function(T value) onPressed;
  final String Function(T value) getLabel;
  WorldMapAppActionItem({
    required this.onPressed,
    required this.getLabel,
  });

  Widget button(T value) {
    return WorldMapAppTextButton(
      label: getLabel(value),
      onPressed: () => onPressed(value),
    );
  }
}
