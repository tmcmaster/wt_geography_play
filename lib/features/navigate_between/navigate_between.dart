import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vector_map/vector_map.dart';
import 'package:wt_geography_play/interactive_world_map/interactive_world_map.dart';
import 'package:wt_geography_play/providers/capital_cities.dart';
import 'package:wt_geography_play/providers/navigate_between_providers.dart';
import 'package:wt_geography_play/providers/providers.dart';

const debug = false;

class NavigateBetween extends ConsumerWidget {
  const NavigateBetween({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _HeaderPanel(),
        Expanded(
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: InteractiveWorldMap(
                  mode: Platform.isMacOS
                      ? VectorMapMode.autoFit
                      : VectorMapMode.panAndZoom,
                  onSelect: (country) {
                    // final navigateBetweenNotifier =
                    //     ref.read(navigateBetweenProvider.notifier);
                    // navigateBetweenNotifier.reset(country);
                    print('Select: $country');
                    if (Platform.isIOS) {
                      final notifier =
                          ref.watch(InteractiveWorldMap.hover.notifier);
                      notifier.state = country;
                    }
                  },
                  onHover: (country) {
                    print('Hover: $country');
                    // final notifier =
                    //     ref.watch(InteractiveWorldMap.hover.notifier);
                    // notifier.state = country;
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: _InfoPanel(),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width,
                height: 50,
                left: 0,
                bottom: 10,
                child: _CountrySelection(),
              ),
              Positioned(
                left: 0,
                bottom: MediaQuery.of(context).size.height / 5,
                // height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width / 5.5,
                child: _ScoresPanel(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ScoresPanel extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme.headline6!.copyWith(
        color: Colors.white, fontSize: MediaQuery.of(context).size.height / 50);

    final distance = ref.watch(distanceNotifierProvider);
    final visitedCountries = ref.watch(InteractiveWorldMap.selected).length;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withOpacity(0.2),
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Colors.black.withOpacity(0.1),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Distance: ${(distance / 1000).toStringAsFixed(0)} km',
            style: style,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            'Visited Countries: $visitedCountries',
            style: style,
          ),
        ],
      ),
    );
  }
}

class _CountrySelection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigateBetween = ref.watch(navigateBetweenProvider);

    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: navigateBetween.countryOptions.map((country) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
              onPressed: () {
                final navigateBetweenNotifier =
                    ref.read(navigateBetweenProvider.notifier);
                navigateBetweenNotifier.select(country);
              },
              child: Text(country.name),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _InfoPanel extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoverCountry = ref.watch(InteractiveWorldMap.hover);
    final navigateBetween = ref.watch(navigateBetweenProvider);

    final style =
        Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white);

    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            navigateBetween.currentCountry?.name ?? '',
            style: style,
          ),
          Text(
            hoverCountry?.name ?? '',
            style: style,
          ),
        ],
      ),
    );
  }
}

class _HeaderPanel extends ConsumerWidget {
  const _HeaderPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigateBetweenNotifier = ref.read(navigateBetweenProvider.notifier);
    final navigateBetween = ref.watch(navigateBetweenProvider);

    final style =
        Theme.of(context).textTheme.headline5!.copyWith(color: Colors.blue);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  navigateBetweenNotifier.reset();
                },
                child: const Text('Reset'),
              ),
              // TODO: need to remove isMacOS
              if (Platform.isIOS || Platform.isMacOS)
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: ZoomModeSwitch(style: style),
                ),
              if (debug)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      navigateBetweenNotifier.test();
                    },
                    child: const Text('Test'),
                  ),
                ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (navigateBetween.startCountry != null)
                Text(
                  navigateBetween.startCountry!.name,
                  style: style,
                ),
              if (navigateBetween.destinationCountry != null)
                Text(
                  ' to ${navigateBetween.destinationCountry!.name}',
                  style: style,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class ZoomModeSwitch extends ConsumerWidget {
  const ZoomModeSwitch({
    Key? key,
    required this.style,
  }) : super(key: key);

  final TextStyle style;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(zoomModeProvider);

    return Row(
      children: [
        Text(
          'Zoom Mode',
          style: style.copyWith(color: Colors.blueGrey),
        ),
        Switch(
          value: enabled,
          onChanged: (enable) {
            ref.read(zoomModeProvider.notifier).enable(enable);
          },
          activeTrackColor: Colors.lightBlue,
          activeColor: Colors.blue,
        )
      ],
    );
  }
}
