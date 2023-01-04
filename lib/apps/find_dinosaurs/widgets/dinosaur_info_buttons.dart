import 'package:flutter/material.dart';
import 'package:wt_geography_play/apps/find_dinosaurs/find_dinosaurs_controller.dart';

class DinosaurInfoButtons extends StatelessWidget {
  final List<String> collected;
  final FindDinosaursController controller;
  final Axis direction;
  final TextStyle? style;

  const DinosaurInfoButtons({
    super.key,
    required this.collected,
    required this.controller,
    this.direction = Axis.vertical,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.transparent,
        child: ListView(
            scrollDirection: direction,
            shrinkWrap: true,
            children: collected
                .map((dinosaurName) => controller.previewDinosaurButton.button(
                      dinosaurName,
                      style: style,
                    ))
                .toList()),
      ),
    );
  }
}
