part of '../scroll_pane.dart';

class ScrollPane extends ConsumerWidget {
  static final log = logger(ScrollPane, level: Level.verbose);
  final _key = GlobalKey();

  final bool panEnabled;
  final List<Widget> children;

  ScrollPane({
    super.key,
    this.panEnabled = false,
    required this.children,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.d('=== Building Widget.');

    final notifier = ref.read(scrollPaneStateProvider.notifier);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey.shade300,
      padding: const EdgeInsets.all(0),
      child: LayoutBuilder(builder: (context, constraints) {
        Future.delayed(const Duration(milliseconds: 10), () {
          notifier.windowResize(constraints.minWidth, constraints.minHeight);
        });
        return Stack(
          key: _key,
          children: [
            ScrollPaneCanvas(
              children: [
                // Container(
                //   width: double.infinity,
                //   height: double.infinity,
                //   decoration: const BoxDecoration(
                //     image: DecorationImage(
                //       repeat: ImageRepeat.repeat,
                //       image: AssetImage('assets/paper-texture.png'),
                //       // repeat: ImageRepeat.repeat,
                //     ),
                //   ),
                // ),
                DragAndPanDetector(
                  panEnabled: true,
                  onPanning: (offset) {
                    log.v(offset);
                  },
                ),
                ...children,
              ],
            ),
          ],
        );
      }),
    );
  }
}
