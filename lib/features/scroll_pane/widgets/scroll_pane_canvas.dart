part of '../scroll_pane.dart';

class ScrollPaneCanvas extends ConsumerWidget {
  static final log = logger(ScrollPaneCanvas, level: Level.warning);

  final List<Widget> children;

  const ScrollPaneCanvas({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.d("Building Widget");

    final state = ref.watch(scrollPaneStateProvider);

    return Positioned(
      left: state.offset.dx,
      top: state.offset.dy,
      child: Container(
        width: state.size.width,
        height: state.size.height,
        color: Colors.grey.shade300,
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            key: stackKey,
            children: children,
          ),
        ),
      ),
    );
  }
}
