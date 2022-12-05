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
        const _ControlPanel(),
        Expanded(
          child: InteractiveWorldMap(
            onSelect: (country) {
              final navigateBetweenNotifier =
                  ref.read(navigateBetweenProvider.notifier);
              navigateBetweenNotifier.reset(country);
            },
          ),
        ),
      ],
    );
  }
}

class _ControlPanel extends ConsumerWidget {
  const _ControlPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoverCountry = ref.watch(InteractiveWorldMap.hover);

    final navigateBetweenNotifier = ref.read(navigateBetweenProvider.notifier);
    final navigateBetween = ref.watch(navigateBetweenProvider);

    final style = Theme.of(context).textTheme.headline5;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      navigateBetweenNotifier.reset();
                    },
                    child: const Text('Reset'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (navigateBetween.currentCountry != null)
                    Text(
                      navigateBetween.currentCountry!.name,
                      style: style,
                    ),
                ],
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
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: navigateBetween.countryOptions.map((country) {
                return ElevatedButton(
                  onPressed: () {
                    final navigateBetweenNotifier =
                        ref.read(navigateBetweenProvider.notifier);
                    navigateBetweenNotifier.select(country);
                  },
                  child: Text(country.name),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
