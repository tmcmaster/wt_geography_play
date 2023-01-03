import 'package:flutter/cupertino.dart';

class WorldMapClipper extends CustomClipper<Path> {
  final Path path;

  WorldMapClipper({
    required this.path,
  });

  @override
  Path getClip(Size size) {
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
