part of 'scroll_pane.dart';

class ScrollPaneCanvas extends ConsumerWidget {
  final Widget child;

  const ScrollPaneCanvas({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('Building ScrollPaneCanvas');
    final state = ref.watch(ScrollPane.state);

    return Positioned(
      left: state.offset.dx,
      top: state.offset.dy,
      height: state.size.height,
      width: state.size.width,
      child: child,
    );
  }
}
