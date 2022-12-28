// part of '../scroll_pane.dart';
//
// class ScrollPaneSelectionBox extends ConsumerWidget {
//   static const debug = false;
//
//   const ScrollPaneSelectionBox({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final region = ref.watch(selectionProvider);
//     final canvasState = ref.watch(scrollPaneStateProvider);
//     return region == null
//         ? Container()
//         : Positioned(
//             left: region.left + canvasState.offset.dx,
//             top: region.top + canvasState.offset.dy,
//             child: Container(
//               width: region.width.toDouble(),
//               height: region.height.toDouble(),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade400.withOpacity(0.3),
//                 border: Border.all(
//                   width: 2,
//                   color: Colors.grey,
//                 ),
//               ),
//               child: debug && region.width > 100 && region.height > 40
//                   ? Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text('Pos(${region.left.toInt()},${region.top.toInt()})'),
//                         Text('Size(${region.width.toInt()}, ${region.height.toInt()})'),
//                       ],
//                     )
//                   : Container(),
//             ),
//           );
//   }
// }
