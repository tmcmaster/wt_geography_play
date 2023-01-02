import 'package:flutter/material.dart';
import 'package:wt_geography_play/features/world_map_app/widgets/world_map_text_button.dart';

class WorldMapActionItem<T> {
  final void Function(T value) onPressed;
  final String Function(T value) getLabel;
  WorldMapActionItem({
    required this.onPressed,
    required this.getLabel,
  });

  Widget button(T value) {
    return WorldMapTextButton(
      label: getLabel(value),
      onPressed: () => onPressed(value),
    );
  }
}
