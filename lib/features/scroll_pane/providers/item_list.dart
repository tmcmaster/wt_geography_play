// part of '../scroll_pane.dart';
//
// final itemCountProvider = Provider((ref) => ref.watch(itemListProvider).length);
//
// final selectedItems = Provider<List<Item>>(
//     (ref) => ref.watch(itemListProvider).where((item) => item.layout.selected).toList());
//
// final itemProvider = Provider.autoDispose.family<Item?, String>(
//   (ref, id) {
//     final options = ref.watch(itemListProvider).where((item) => item.id == id);
//
//     return options.isEmpty
//         ? null
//         : ref.watch(itemListProvider).where((item) => item.id == id).first;
//   },
// );
//
// final itemListProvider = StateNotifierProvider<ItemListNotifier, List<Item>>(
//   (ref) => ItemListNotifier(ref),
// );
//
// class ItemListNotifier extends StateNotifier<List<Item>> {
//   static const uuid = Uuid();
//
//   final Ref ref;
//
//   ItemListNotifier(this.ref) : super([]) {
//     Future.delayed(const Duration(milliseconds: 100), () {
//       try {
//         load();
//       } catch (error) {
//         print(error);
//       }
//     });
//   }
//
//   void add(Item newItem) {
//     // TODO: need to move this offset logic to _updateState and then make this function call _updateState.
//     final offset = Offset(
//       newItem.layout.point.x < 0 ? newItem.layout.point.x * -1 : 0,
//       newItem.layout.point.y < 0 ? newItem.layout.point.y * -1 : 0,
//     );
//
//     if (offset.dx > 0 || offset.dy > 0) {
//       // move all of the items to the right
//       state = [
//         ...state
//             .map((item) => item.copyWith(
//                   layout: item.layout.copyWith(
//                     point: Point(
//                       item.layout.point.x + offset.dx,
//                       item.layout.point.y + offset.dy,
//                     ),
//                   ),
//                 ))
//             .toList(),
//         newItem.copyWith(
//           layout: newItem.layout.copyWith(
//               point: Point(
//             newItem.layout.point.x + offset.dx,
//             newItem.layout.point.y + offset.dy,
//           )),
//         ),
//       ];
//     } else {
//       state = [
//         ...state,
//         newItem,
//       ];
//     }
//   }
//
//   // TODO: need to review enabling items to be dragged off screen at the top and left.
//
//   void updateItems(List<Item> items) {
//     final itemMap = <String, Item>{for (var item in items) item.id: item};
//     final newState = state.map((e) => itemMap[e.id] == null ? e : (itemMap[e.id] ?? e)).toList();
//     _updateState(newState, items);
//   }
//
//   void updateItem(Item newItem, {bool save = false}) {
//     final newState = [...state.where((item) => item.id != newItem.id).toList(), newItem];
//     _updateState(newState, [newItem]);
//     if (save) {
//       this.save();
//     }
//   }
//
//   void _updateState(List<Item> newState, List<Item> changedItems) {
//     // TODO: need to check if any of the changedItems are off the left or top of the screen
//     //        if so, find the larges offset for the x and y, and translate all of the items.
//
//     final offset = _findMostLeftTopOffset(changedItems);
//
//     if (offset.dx < 0 || offset.dy < 0) {
//       state = newState.map((item) {
//         Item newItem = item.copyWith(
//           layout: item.layout.copyWith(
//             point: Point(
//               item.layout.point.x + offset.dx,
//               item.layout.point.y + offset.dy,
//             ),
//           ),
//         );
//         return newItem;
//       }).toList();
//     } else {
//       state = newState;
//     }
//   }
//
//   Offset _findMostLeftTopOffset(List<Item> items) {
//     return items.fold(
//         const Offset(0, 0),
//         (offset, item) => Offset(
//               item.layout.point.x < offset.dx ? item.layout.point.x : offset.dx,
//               item.layout.point.y < offset.dy ? item.layout.point.y : offset.dy,
//             ));
//   }
//
//   void clearSelection() {
//     state = state.map((item) {
//       final Item newItem = item.layout.selected
//           ? item.copyWith(
//               layout: item.layout.copyWith(
//                 selected: false,
//               ),
//             )
//           : item;
//       return newItem;
//     }).toList();
//   }
//
//   void clearHighlight() {
//     state = state.map((Item item) {
//       final Item newItem = item.layout.highlighted ? item.copyWith() : item;
//       return item;
//     }).toList();
//   }
//
//   void toggleSelection(Item itemToToggle, {bool clearSelection = false}) {
//     state = [
//       ...state
//           .where((item) => item.id != itemToToggle.id)
//           .map((item) => clearSelection ? item.copyWith(selected: false) : item)
//           .toList(),
//       itemToToggle.copyWith(selected: !itemToToggle.layout.selected),
//     ];
//   }
//
//   void load() {
//     // final itemListJson = ref.read(itemListJsonProvider);
//     // state = itemListJson.map((map) => Item.fromJson(map)).toList();
//
//     ref.read(FirebaseProviders.database).ref('/v1/state').get().then((snapshot) {
//       if (snapshot.exists) {
//         final List<Map<String, dynamic>> itemListJson =
//             firebaseMapListToJsonMapList(snapshot.value);
//
//         print('Items: ${itemListJson.length}');
//
//         state = Item.fromJsonList(itemListJson);
//       }
//     });
//   }
//
//   List<Map<String, dynamic>> firebaseMapListToJsonMapList(Object? object) {
//     if (object is List<Object?>) {
//       return object.map((obj) {
//         final ooo = obj as Map<Object?, Object?>;
//         return Map.fromEntries(ooo.entries
//             .map((e) => MapEntry(e.key.toString(), firebaseObjectToJson(e.value)))
//             .toList());
//       }).toList();
//     } else {
//       return [];
//     }
//   }
//
//   dynamic firebaseObjectToJson(Object? object) {
//     if (object == null) {
//       return null;
//     } else if (object is List<Object?>) {
//       return object.map((o) => firebaseObjectToJson(o)).toList();
//     } else if (object is Map<Object?, Object?>) {
//       return Map.fromEntries(
//           object.entries.map((e) => MapEntry(e.key.toString(), firebaseObjectToJson(e.value))));
//     } else {
//       return object;
//     }
//   }
//
//   List<Map<String, dynamic>> firebaseListToJson(Object? data) {
//     if (data == null) {
//       return [];
//     }
//
//     if (data is List<Object?>) {
//       return data.map((e) => firebaseMapToJson(e)).toList();
//     }
//
//     return [];
//   }
//
//   Map<String, dynamic> firebaseMapToJson(Object? object) {
//     if (object == null) {
//       return {};
//     }
//
//     final map = object as Map<Object?, Object?>;
//
//     return Map.fromEntries(map.entries.map((e) => MapEntry(e.key.toString(), e.value)));
//   }
//
//   void save() {
//     // ref
//     //     .read(FirebaseProviders.auth)
//     //     .signInWithEmailAndPassword(email: 'tim@wonkytech.net', password: 'LetMeInPlease')
//     //     .then((value) {
//     //   print('Database: ${ref.read(FirebaseProviders.database).app.name}');
//     //
//
//     final json = state.map((item) => item.toJson()).toList();
//     // ref.read(itemListJsonProvider.notifier).update(json);
//     ref.read(FirebaseProviders.database).ref('/v1/state').set(json);
//
//     // ref
//     //     .read(FirebaseProviders.database)
//     //     .ref('/v1/state')
//     //     .get()
//     //     .then((snapshot) => print('===>> State: ${snapshot.value}'));
//     // });
//   }
//
//   void clear([bool onlySelected = false]) {
//     if (onlySelected) {
//       state = state.where((item) => !item.layout.selected).toList();
//     } else {
//       state = [];
//     }
//   }
//
//   String getDefinition() {
//     return json.encode([...state].map((item) => item.toJson()).toList());
//   }
//
//   // TODO: need to investigate why intersection seems to be selecting extra items.
//   void selectInRegion(Rectangle region) {
//     // print('Region(${region.left.toInt()},${region.top.toInt()} : (${region.width.toInt()} x ${region.height.toInt()}))');
//     state = state.map((Item item) {
//       final isWithin = region.intersection(item.layout.bounds) != null;
//       final Item newItem = isWithin
//           ? item.copyWith(
//               layout: item.layout.copyWith(
//                 selected: true,
//               ),
//             )
//           : item.copyWith(
//               layout: item.layout.copyWith(
//                 selected: false,
//               ),
//             );
//       return newItem;
//     }).toList();
//   }
//
//   bool isWithin(Item item, Rectangle region) {
//     final isBetween = (item.layout.point.x > region.left &&
//         item.layout.point.x < region.right &&
//         item.layout.point.y > region.top &&
//         item.layout.point.y < region.bottom);
//
//     return isBetween;
//   }
//
//   void horizontalCenterAlign(List<Item> items) {
//     return _align(items, (item) => Offset(item.layout.point.x + (item.layout.size.width / 2), 0));
//   }
//
//   void leftAlign(List<Item> items) {
//     return _align(items, (item) => Offset(item.layout.point.x.toDouble(), 0));
//   }
//
//   void rightAlign(List<Item> items) {
//     return _align(items, (item) => Offset(item.layout.point.x + item.layout.size.width, 0));
//   }
//
//   void verticalCenterAlign(List<Item> items) {
//     return _align(items, (item) => Offset(0, item.layout.point.y + (item.layout.size.height / 2)));
//   }
//
//   void topAlign(List<Item> items) {
//     return _align(items, (item) => Offset(0, item.layout.point.y.toDouble()));
//   }
//
//   void bottomAlign(List<Item> items) {
//     return _align(items, (item) => Offset(0, item.layout.point.y + item.layout.size.height));
//   }
//
//   void _align(List<Item> items, Offset Function(Item) getValue) {
//     if (items.length < 2) {
//       throw Exception('More than one items need to be selected,');
//     }
//     final firstItem = items[0];
//     final requiredValue = getValue(firstItem);
//     final List<Item> updatedItems = items.sublist(1).map((item) {
//       final value = getValue(item);
//       final offset = requiredValue - value;
//       final Item newItem = item.copyWith(
//         layout: item.layout.copyWith(
//           point: Point(
//             item.layout.point.x + offset.dx,
//             item.layout.point.y + offset.dy,
//           ),
//         ),
//       );
//       return newItem;
//     }).toList();
//     updateItems(updatedItems);
//   }
//
//   void bringToFront(Item selectedItem) {
//     state = state.where((item) => item.id != selectedItem.id).toList();
//     Future.delayed(const Duration(milliseconds: 50), () {
//       add(selectedItem);
//     });
//   }
//
//   void resizeItem(String id, Offset delta) {
//     state = state.map((item) {
//       final Item newItem = item.id != id
//           ? item
//           : item.copyWith(
//               layout: item.layout.copyWith(
//                 size: Size(
//                   item.layout.size.width + delta.dx,
//                   item.layout.size.height + delta.dy,
//                 ),
//               ),
//             );
//       return newItem;
//     }).toList();
//   }
//
//   void moveItem(String id, Offset delta) {
//     state = state.map((Item item) {
//       final Item newItem = item.id != id
//           ? item
//           : item.copyWith(
//               layout: item.layout.copyWith(
//                 point: Point(
//                   item.layout.point.x + delta.dx,
//                   item.layout.point.y + delta.dy,
//                 ),
//                 highlighted: true,
//               ),
//             );
//       return newItem;
//     }).toList();
//   }
//
//   void moveSelected(String id, Offset delta) {
//     state = state.map((item) {
//       final Item newItem = item.id == id || !item.layout.selected
//           ? item
//           : item.copyWith(
//               layout: item.layout.copyWith(
//                 point: Point(
//                   item.layout.point.x + delta.dx,
//                   item.layout.point.y + delta.dy,
//                 ),
//                 highlighted: true,
//               ),
//             );
//       return newItem;
//     }).toList();
//   }
// }
