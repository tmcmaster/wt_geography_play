import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/scroll_pane/scroll_pane.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map.dart';

class WorldMapApp extends ConsumerWidget {
  final List<Widget> leftHeader;
  final List<Widget> rightHeader;
  final List<Widget> leftFooter;
  final List<Widget> rightFooter;
  final bool zoomControls;
  final void Function(String country)? onSelect;
  final void Function(String country)? onHover;

  const WorldMapApp({
    super.key,
    this.leftHeader = const [],
    this.rightHeader = const [],
    this.leftFooter = const [],
    this.rightFooter = const [],
    this.zoomControls = true,
    this.onSelect,
    this.onHover,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _TopToolbar(leftHeader: leftHeader, rightHeader: rightHeader, zoomControls: zoomControls),
        Expanded(
          child: _MapSection(
            onSelect: onSelect,
            onHover: onHover,
          ),
        ),
        _BottomToolbar(leftFooter: leftFooter, rightFooter: rightFooter),
      ],
    );
  }
}

class _MapSection extends ConsumerWidget {
  final void Function(String country)? onSelect;
  final void Function(String country)? onHover;

  const _MapSection({
    super.key,
    this.onSelect,
    this.onHover,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.2,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                scale: 1,
                repeat: ImageRepeat.repeat,
                image: AssetImage('assets/ocean_texture.jpeg'),
                // repeat: ImageRepeat.repeat,
              ),
            ),
          ),
        ),
        ScrollPane(
          child: WorldMap(
            onSelect: onSelect,
            onHover: onHover,
          ),
        ),
      ],
    );
  }
}

class _BottomToolbar extends StatelessWidget {
  const _BottomToolbar({
    Key? key,
    required this.leftFooter,
    required this.rightFooter,
  }) : super(key: key);

  final List<Widget> leftFooter;
  final List<Widget> rightFooter;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade400,
            width: 2,
          ),
        ),
        color: Colors.grey.shade200,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: leftFooter,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: rightFooter,
          )
        ],
      ),
    );
  }
}

class _TopToolbar extends StatelessWidget {
  const _TopToolbar({
    Key? key,
    required this.leftHeader,
    required this.rightHeader,
    required this.zoomControls,
  }) : super(key: key);

  final List<Widget> leftHeader;
  final List<Widget> rightHeader;
  final bool zoomControls;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade400,
            width: 2,
          ),
        ),
        color: Colors.grey.shade200,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: leftHeader,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...rightHeader,
              if (zoomControls) const _ZoomControls(),
            ],
          )
        ],
      ),
    );
  }
}

class _ZoomControls extends ConsumerWidget {
  const _ZoomControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(ScrollPane.state.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.fit_screen),
          hoverColor: Colors.transparent,
          onPressed: () {
            notifier.fitScreen();
          },
        ),
        IconButton(
          icon: const Icon(Icons.add),
          hoverColor: Colors.transparent,
          onPressed: () {
            notifier.scale(1.5);
          },
        ),
        IconButton(
          icon: const Icon(Icons.remove),
          hoverColor: Colors.transparent,
          onPressed: () {
            notifier.scale(2 / 3);
          },
        ),
      ],
    );
  }
}
