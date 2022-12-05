import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/interactive_world_map/interactive_world_map.dart';
import 'package:wt_geography_play/providers/navigate_between_providers.dart';

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
              InteractiveWorldMap(
                onSelect: (country) {
                  final navigateBetweenNotifier =
                      ref.read(navigateBetweenProvider.notifier);
                  navigateBetweenNotifier.reset(country);
                },
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
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _CountrySelection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigateBetween = ref.watch(navigateBetweenProvider);

    return Padding(
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

    return Padding(
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

class _HeaderPanel extends ConsumerWidget {
  const _HeaderPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigateBetweenNotifier = ref.read(navigateBetweenProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              navigateBetweenNotifier.reset();
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
