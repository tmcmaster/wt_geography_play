import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_geography_play/features/world_map/models/shape.dart';
import 'package:wt_geography_play/features/world_map/providers/selected_countries.dart';

class ShapeWidget extends ConsumerWidget {
  static final log = logger(ShapeWidget, level: Level.warning);

  static String? hovering;

  final String country;
  final Shape shape;
  final double scale;
  final Color color;
  final bool shadow;
  final AutoDisposeProvider<bool> selectedProvider;

  const ShapeWidget({
    super.key,
    required this.country,
    required this.shape,
    this.scale = 1,
    this.color = Colors.red,
    this.shadow = true,
    required this.selectedProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v('Building Widget : $country');
    final notifier = ref.read(selectedCountriesProvider.notifier);
    return Positioned(
      left: shape.offset.dx * scale,
      top: shape.offset.dy * scale,
      width: shape.size.width * scale + 20,
      height: shape.size.height * scale + 20,
      child: shadow
          ? IgnorePointer(
              child: ClipShadowPath(
                clipper: CustomClipPath(
                  shape: shape,
                  scale: scale,
                ),
                shadow: const Shadow(
                  color: Colors.grey,
                  offset: Offset(-10, 10),
                  blurRadius: 10.0,
                ),
                child: Container(
                  color: color,
                ),
              ),
            )
          : ClipShadowPath(
              clipper: CustomClipPath(
                shape: shape,
                scale: scale,
              ),
              shadow: const Shadow(
                color: Colors.black,
                offset: Offset(0, 0),
                blurRadius: 1.0,
              ),
              child: Listener(
                // onPointerPanZoomUpdate: (event) {
                //   log.v('Zoom : $country');
                // },
                onPointerHover: (event) {
                  if (hovering != country) {
                    log.v('Hover : $country');
                    hovering = country;
                  }
                },
                child: GestureDetector(
                  // onPanUpdate: (details) {
                  //   log.v('Pan Update');
                  // },
                  onTap: () {
                    log.v('Tap : $country');
                    notifier.select(country);
                  },
                  child: ShapeContainer(
                    country: country,
                    color: color,
                    selectedProvider: selectedProvider,
                  ),
                ),
              ),
            ),
    );
  }
}

class ShapeContainer extends ConsumerWidget {
  static final log = logger(ShapeContainer, level: Level.verbose);

  const ShapeContainer({
    super.key,
    required this.country,
    required this.color,
    required this.selectedProvider,
  });

  final String country;
  final Color color;
  final AutoDisposeProvider<bool> selectedProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v('Building Widget : $country');
    final selected = ref.watch(selectedProvider);
    return Stack(
      children: [
        Container(
          color: selected ? color : Colors.grey.shade300,
        ),
        Container(
          color: Colors.white.withOpacity(0.5),
        )
      ],
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  final Shape shape;
  final double scale;
  CustomClipPath({
    required this.shape,
    this.scale = 1,
  });

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(shape.points[0].x * scale, shape.points[0].y * scale);
    for (var i = 1; i < shape.points.length; i++) {
      path.lineTo(shape.points[i].x * scale, shape.points[i].y * scale);
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  const ClipShadowPath({
    Key? key,
    required this.shadow,
    required this.clipper,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: clipper,
        shadow: shadow,
      ),
      child: ClipPath(
        clipper: clipper,
        child: child,
      ),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool hitTest(Offset position) {
    // TODO: need to review always making this false.
    return false;
    // Path path = Path();
    // path.close();
    // return path.contains(position);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
