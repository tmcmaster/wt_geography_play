import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/find_country/providers/next_country_to_find.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map.dart';
import 'package:wt_geography_play/features/world_map_app/world_map_app.dart';

void main() {
  runApp(const ProviderScope(
    child: MaterialApp(
      title: 'World Map App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FindCountryApp(),
      ),
    ),
  ));
}

class FindCountryApp extends ConsumerWidget {
  const FindCountryApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoverNotifier = ref.read(WorldMap.hoverCountry.notifier);

    return WorldMapApp(
      zoomControls: true,
      onSelect: (country) {
        final nextCountry = ref.watch(nextCountryToFind);
        if (country == nextCountry) {
          ref.read(WorldMap.selectedCountries.notifier).select(country);
        }
      },
      onHover: (country) {
        hoverNotifier.set(country);
      },
      leftHeader: const [
        CountryToFind(),
      ],
      rightHeader: const [],
      leftFooter: const [
        HoverCountry(),
      ],
      rightFooter: [
        IconButton(
          icon: const Icon(Icons.question_mark_outlined),
          hoverColor: Colors.transparent,
          onPressed: () {
            final country = ref.read(nextCountryToFind);
            ref.read(WorldMap.selectedCountries.notifier).select(country);
          },
        ),
      ],
    );
  }
}

class CountryToFind extends ConsumerWidget {
  const CountryToFind({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nextCountry = ref.watch(nextCountryToFind);
    return Text(
      nextCountry,
      style: const TextStyle(
        color: Colors.blueAccent,
        fontSize: 24,
      ),
    );
  }
}

class HoverCountry extends ConsumerWidget {
  const HoverCountry({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoverCountry = ref.watch(WorldMap.hoverCountry);
    return Text(
      hoverCountry,
      style: const TextStyle(
        color: Colors.blueAccent,
        fontSize: 16,
      ),
    );
  }
}
