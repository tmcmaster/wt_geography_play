part of '../scroll_pane.dart';

final stackKey = GlobalKey();

final scrollPaneStateProvider = StateNotifierProvider<ScrollPaneStateNotifier, ScrollPaneState>(
  (ref) => ScrollPaneStateNotifier(),
);

class ScrollPaneStateNotifier extends StateNotifier<ScrollPaneState> {
  ScrollPaneStateNotifier()
      : super(ScrollPaneState(
          offset: const Offset(0, 0),
          size: const Size(400, 400),
          screen: const Size(400, 400),
        ));

  void setOffset(offset) {
    state = state.copyWith(offset: offset);
  }

  void movePoint(Offset offset) {
    // print('Screen Width: ${state.screen.width}');
    state = state.copyWith(
      offset: Offset(
        state.offset.dx + offset.dx >= 0
            ? 0
            : state.size.width + state.offset.dx <= state.screen.width
                ? state.offset.dx + 1
                : state.offset.dx + offset.dx,
        state.offset.dy + offset.dy >= 0
            ? 0
            : state.size.height + state.offset.dy <= state.screen.height
                ? state.offset.dy + 1
                : state.offset.dy + offset.dy,
      ),
    );
  }

  void update({
    Offset? offset,
    Size? size,
  }) {
    state = state.copyWith(
      offset: offset,
      size: size,
    );
  }

  void windowResize(double screenWidth, double screenHeight) {
    final newWidth = state.size.width < screenWidth ? screenWidth : state.size.width;
    final newHeight = state.size.height < screenHeight ? screenHeight : state.size.height;
    if (state.size.width < screenWidth || state.size.height < screenHeight) {
      state =
          state.copyWith(size: Size(newWidth, newHeight), screen: Size(screenWidth, screenHeight));
    } else {
      state = state.copyWith(screen: Size(screenWidth, screenHeight));
    }
  }
}
