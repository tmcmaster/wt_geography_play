// part of '../scroll_pane.dart';
//
//
// final selectionProvider = StateNotifierProvider<SelectionStateNotifier, Rectangle<double>?>(
//   (ref) => SelectionStateNotifier(ref),
// );
//
// class SelectionStateNotifier extends StateNotifier<Rectangle<double>?> {
//   final Ref ref;
//   Point<double>? _start;
//   Point<double>? _end;
//
//   SelectionStateNotifier(this.ref) : super(null);
//
//   void start(Point<double> point) {
//     _start = point;
//   }
//
//   void drag(Point<double> point) {
//     if (_start != null) {
//       final x = point.x - _start!.x;
//       final y = point.y - _start!.y;
//       _end = Point(x, y);
//       if (_start != null && _end != null) {
//         state = Rectangle(_start!.x, _start!.y, _end!.x, _end!.y);
//       }
//     }
//   }
//
//   // void end() {
//   //   if (state != null) {
//   //     ref.read(itemListProvider.notifier).selectInRegion(state!);
//   //   }
//   //   clear();
//   // }
//
//   void clear() {
//     _start = null;
//     _end = null;
//     state = null;
//   }
//
//   void setRegion(Rectangle<double> region) {
//     state = region;
//   }
// }
