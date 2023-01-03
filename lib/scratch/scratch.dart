import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/apps/explore_map/explore_map_controller.dart';
import 'package:wt_geography_play/features/world_map/models/world_map_country.dart';
import 'package:wt_geography_play/features/world_map/providers/selected_countries.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map/world_map_canvas.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map/world_map_controller.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map_shadow/world_map_shadow.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(
    child: ScratchApp(),
  ));
}

class ScratchApp extends StatelessWidget {
  const ScratchApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.lightBlue.shade50,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Expanded(child: WorldMapTestWidget()),
            ],
          ),
        ),
      ),
    );
  }
}

class WorldMapTestWidget extends ConsumerWidget {
  const WorldMapTestWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(ExploreMapController.provider);
    final countries = ref
        .read(WorldMapController.countryMap)
        .values
        .where((country) => country.continent.isNotEmpty)
        // .where((c) => c.continent == 'South America')
        // .where((c) => c.continent == 'Africa')
        .where((c) => c.name == 'Australia')
        .toList();

    if (countries.isEmpty) {
      return Container();
    }

    final region = WorldMapController.countiesToRegion(countries);
    final scale = 1600 / region.width;
    final offset = Offset(-region.left, -region.top);
    const shadowOffset = Offset(8, 8);
    final size = Size(
      region.width * scale + shadowOffset.dx,
      region.height * scale + shadowOffset.dy,
    );

    print('AAAAA Size: $size, Scale: $scale');

    return FittedBox(
      child: WorldMapCanvas(
        size: size,
        children: controller.countriesToWidgets(
          countries,
          scale: scale,
          offset: offset,
          shadowOffset: shadowOffset,
        ),
      ),
    );
  }
}

class TestShapeWidget extends ConsumerWidget {
  const TestShapeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryMap = ref.watch(WorldMapController.countryMap);
    final countries = countryMap.values
        .where((country) => country.continent.isNotEmpty)
        .where((c) => c.continent == 'Australia')
        .toList();

    final controller = ref.read(ExploreMapController.provider);

    final notifier = ref.read(controller.selectedCountries.notifier);

    final region = WorldMapController.countiesToRegion(countries);

    return FittedBox(
      child: SizedBox(
        width: region.width * 4.3 + 10,
        height: region.height * 4.3 + 10,
        child: Stack(
          // children: testShapeWidget(countries, controller, notifier, region),
          children: [
            Container(
              color: Colors.yellow,
            ),
            // ...testWorldMapShadow(countries),
            ...testWorldMapShadowWithCountries(countries, controller),
          ],
        ),
      ),
    );
  }

  List<Widget> testShapeWidget(List<WorldMapCountry> countries, ExploreMapController controller,
      SelectedCountriesNotifier notifier, Rectangle<double> region) {
    return countries.isEmpty
        ? []
        : controller.fromCountryList(
            countries,
            shadow: true,
            onSelect: (country) => notifier.select(country),
            offset: Offset(-region.left, -region.top),
          );
  }

  List<Widget> testWorldMapShadow(List<WorldMapCountry> countries) {
    return [
      WorldMapShadow(
        countries: countries,
        scale: 4.3,
        offset: const Offset(0, 10),
      ),
    ];
  }

  static List<Widget> testWorldMapShadowWithCountries(
    List<WorldMapCountry> countries,
    ExploreMapController controller,
  ) {
    final countryWidgets = controller.fromCountryList(countries, shadow: false);
    return [
      WorldMapShadow(
        countries: countries,
        scale: 4.3,
        offset: const Offset(0, 0),
      ),
      ...countryWidgets,
    ];
  }
}

class TestWorldMap extends ConsumerWidget {
  const TestWorldMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(ExploreMapController.provider);

    return FittedBox(
      child: WorldMap(
        controller: controller,
      ),
    );
  }
}
