part of 'scroll_pane.dart';

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
    if (state.screen.width == state.size.width && state.screen.height == state.size.height) {
      return;
    }

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
      state = state.copyWith(
        size: Size(newWidth, newHeight),
        screen: Size(screenWidth, screenHeight),
      );
    } else {
      state = state.copyWith(
        screen: Size(screenWidth, screenHeight),
      );
    }
  }

  void scale(double scale) {
    final scalledSize = Size(
      ((state.size.width / 1600).round() * scale) * 1600,
      ((state.size.height / 800).round() * scale) * 800,
    );

    final newSize = Size(
      scalledSize.width < state.screen.width
          ? state.screen.width
          : scalledSize.width > 4800
              ? 4800
              : (scalledSize.width / state.screen.width).abs() < 1.2
                  ? state.screen.width
                  : scalledSize.width,
      scalledSize.height < state.screen.height
          ? state.screen.height
          : scalledSize.height > 2400
              ? 2400
              : (scalledSize.height / state.screen.height).abs() < 1.2
                  ? state.screen.height
                  : scalledSize.height > scalledSize.width / 2
                      ? scalledSize.width / 2
                      : scalledSize.height,
    );

    // final newScale = newSize.width / state.size.width;
    //
    // final newOffset = Offset(
    //   state.offset.dx * newScale,
    //   state.offset.dy * newScale,
    // );

    // print('New Scale: $newScale');
    // print('New Offset: $newOffset');
    // print('Screen Size: ${state.screen}');
    // print('New Size: $scalledSize');
    // print('Diff: ${(scalledSize.width / state.screen.width).abs()}');

    state = state.copyWith(
      offset: const Offset(0, 0),
      size: newSize,
    );
  }

  void fitScreen() {
    state = state.copyWith(
      offset: const Offset(0, 0),
      size: Size(
        state.screen.width,
        state.screen.height,
      ),
    );
  }
}
