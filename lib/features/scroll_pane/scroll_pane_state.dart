part of 'scroll_pane.dart';

class ScrollPaneState {
  final Offset offset;
  final Size size;
  final Size screen;

  ScrollPaneState({
    required this.offset,
    required this.size,
    required this.screen,
  });

  ScrollPaneState copyWith({
    Offset? offset,
    Size? size,
    Size? screen,
  }) {
    return ScrollPaneState(
      offset: offset ?? this.offset,
      size: size ?? this.size,
      screen: screen ?? this.screen,
    );
  }

  @override
  String toString() {
    return 'State(OffSet(${offset.dx},${offset.dy}), Size(${size.width},${size.height})';
  }
}
