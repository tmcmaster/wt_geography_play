import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/scroll_pane/scroll_pane.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map.dart';

void main() {
  runApp(const ProviderScope(
    child: ScrollPaneApp(),
  ));
}

class ScrollPaneApp extends ConsumerWidget {
  static final stackKey = GlobalKey();
  const ScrollPaneApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(scrollPaneStateProvider.notifier);

    return MaterialApp(
      title: 'Scroll Pane App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Scroll Pane App'),
          actions: [
            IconButton(
              icon: const Icon(Icons.fit_screen),
              onPressed: () {
                notifier.fitScreen();
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                notifier.scale(1.5);
              },
            ),
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                notifier.scale(2 / 3);
              },
            ),
          ],
        ),
        body: const ScrollPane(),
      ),
    );
  }
}

class ScrollPane extends ConsumerWidget {
  const ScrollPane({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('Building ScrollPane');

    Offset? start;

    final size = ref.watch(scrollPaneStateProvider.select((value) => value.size));
    print('Map Size changed: $size');
    final notifier = ref.read(scrollPaneStateProvider.notifier);

    final window = Stack(
      children: [
        const ScrollPaneCanvas(
          child: WorldMap(),
        ),
        GestureDetector(
          onPanUpdate: (details) {
            if (start == null) {
              // print('Moving: $details');
              notifier.movePoint(details.delta);
            } else {
              // print('Panning: $details');
            }
          },
          onPanEnd: (details) {
            print('Pan End');
            start = null;
          },
        )
      ],
    );

    return LayoutBuilder(builder: (_, constraints) {
      print('Building LayoutBuilder');
      Future.delayed(const Duration(milliseconds: 1), () {
        notifier.windowResize(
          constraints.maxWidth.toDouble(),
          constraints.maxHeight.toDouble(),
        );
      });
      return window;
    });
  }
}

class ScrollPaneCanvas extends ConsumerWidget {
  final Widget child;

  const ScrollPaneCanvas({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('Building ScrollPaneCanvas');
    final state = ref.watch(scrollPaneStateProvider);

    return Positioned(
      left: state.offset.dx,
      top: state.offset.dy,
      height: state.size.height,
      width: state.size.width,
      child: Center(
        child: AspectRatio(
          aspectRatio: 2,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: child,
          ),
        ),
      ),
    );
  }
}
