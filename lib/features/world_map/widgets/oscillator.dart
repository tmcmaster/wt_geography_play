import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Oscillator extends StatefulWidget {
  final double width;
  final double height;
  final Widget child;
  final int interval;
  final int duration;
  final int magnitude;

  const Oscillator({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    this.interval = 5,
    this.duration = 5,
    this.magnitude = 40,
  });

  @override
  State<Oscillator> createState() => _OscillatorState();
}

class _OscillatorState extends State<Oscillator> {
  static final random = Random();

  Timer? timer;

  Offset offset = const Offset(0, 0);

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: widget.interval), (timer) {
      setState(() {
        offset = Offset(
          offset.dx + (random.nextInt(widget.magnitude) * (offset.dx < -widget.magnitude ? 1 : -1)),
          offset.dy + (random.nextInt(widget.magnitude) * (offset.dy < -widget.magnitude ? 1 : -1)),
        );
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(seconds: widget.duration),
      curve: Curves.easeInOut,
      left: offset.dx,
      top: offset.dy,
      child: SizedBox(
        width: widget.width + (widget.magnitude * 4),
        height: widget.height + (widget.magnitude * 4),
        child: widget.child,
      ),
    );
  }
}
