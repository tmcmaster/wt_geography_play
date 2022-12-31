import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_geography_play/features/scroll_pane/scroll_pane.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map.dart';

class WorldMapApp extends ConsumerWidget {
  final String appName;
  final List<Widget> leftHeader;
  final List<Widget> rightHeader;
  final List<Widget> leftFooter;
  final List<Widget> rightFooter;
  final bool zoomControls;
  final void Function(String country)? onSelect;
  final void Function(String country)? onHover;
  final List<Widget> infoPanels;

  const WorldMapApp({
    super.key,
    required this.appName,
    this.leftHeader = const [],
    this.rightHeader = const [],
    this.leftFooter = const [],
    this.rightFooter = const [],
    this.zoomControls = true,
    this.onSelect,
    this.onHover,
    this.infoPanels = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          _TopToolbar(leftHeader: leftHeader, rightHeader: rightHeader),
          Expanded(
            child: _MapSection(
              appName: appName,
              onSelect: onSelect,
              onHover: onHover,
              infoPanels: infoPanels,
            ),
          ),
          _BottomToolbar(
              leftFooter: leftFooter, rightFooter: rightFooter, zoomControls: zoomControls),
        ],
      ),
    );
  }
}

class _MapSection extends ConsumerWidget {
  final String appName;
  final void Function(String country)? onSelect;
  final void Function(String country)? onHover;
  final List<Widget> infoPanels;

  const _MapSection({
    super.key,
    required this.appName,
    this.onSelect,
    this.onHover,
    this.infoPanels = const [],
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
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Opacity(
              opacity: 0.3,
              child: Text(
                appName,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 24,
                ),
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
        ...infoPanels,
      ],
    );
  }
}

class _BottomToolbar extends StatelessWidget {
  const _BottomToolbar({
    Key? key,
    required this.leftFooter,
    required this.rightFooter,
    required this.zoomControls,
  }) : super(key: key);

  final List<Widget> leftFooter;
  final List<Widget> rightFooter;
  final bool zoomControls;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
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
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: leftFooter,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ...rightFooter,
              if (zoomControls) const _ZoomControls(),
            ],
          )
        ],
      ),
    );
  }
}

class _TopToolbar extends ConsumerWidget {
  const _TopToolbar({
    Key? key,
    required this.leftHeader,
    required this.rightHeader,
  }) : super(key: key);

  final List<Widget> leftHeader;
  final List<Widget> rightHeader;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHiddenDraw =
        ref.read(ApplicationSettings.applicationType.value) == ApplicationType.hiddenDrawer;

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
            children: [
              if (isHiddenDraw)
                IconButton(
                  onPressed: () {
                    HiddenDrawerOpener.of(context)?.open();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.blueGrey,
                  ),
                ),
              ...leftHeader
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...rightHeader,
              IconButton(
                focusColor: Colors.transparent,
                onPressed: () {
                  ref.read(WorldMap.selectedCountries.notifier).clear();
                },
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.blueGrey,
                ),
              ),
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
          icon: const Icon(
            Icons.fit_screen,
            color: Colors.blueGrey,
          ),
          hoverColor: Colors.transparent,
          onPressed: () {
            notifier.fitScreen();
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.blueGrey,
          ),
          hoverColor: Colors.transparent,
          onPressed: () {
            notifier.scale(1.5);
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.remove,
            color: Colors.blueGrey,
          ),
          hoverColor: Colors.transparent,
          onPressed: () {
            notifier.scale(2 / 3);
          },
        ),
      ],
    );
  }
}
