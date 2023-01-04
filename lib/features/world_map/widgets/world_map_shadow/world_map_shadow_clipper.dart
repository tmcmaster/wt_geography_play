import 'package:flutter/cupertino.dart';

class WorldMapShadowClipper extends CustomClipper<Path> {
  final Path path;

  WorldMapShadowClipper({
    required this.path,
  });

  @override
  Path getClip(Size size) {
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
