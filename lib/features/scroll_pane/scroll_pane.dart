import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_logging/wt_logging.dart';

part 'scroll_pane_canvas.dart';
part 'scroll_pane_notifier.dart';
part 'scroll_pane_state.dart';

class ScrollPane extends ConsumerWidget {
  static final log = logger(ScrollPane, level: Level.warning);

  static final state = StateNotifierProvider<ScrollPaneStateNotifier, ScrollPaneState>(
    (ref) => ScrollPaneStateNotifier(),
  );

  final Widget child;

  const ScrollPane({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v('Building ScrollPane');

    Offset? start;

    final notifier = ref.read(state.notifier);

    final window = Stack(
      children: [
        ScrollPaneCanvas(
          child: Center(
            child: AspectRatio(
              aspectRatio: 2,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: child,
              ),
            ),
          ),
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
            log.v('Pan End');
            start = null;
          },
        )
      ],
    );

    return LayoutBuilder(builder: (_, constraints) {
      log.v('Building LayoutBuilder');
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
