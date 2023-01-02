import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map/world_map_controller.dart';

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Expanded(child: TestShapeWidget()),
            ],
          ),
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
    final countries = countryMap.values.where((country) => country.name == 'New Zealand').toList();

    final notifier = ref.read(WorldMapController.selectedCountries.notifier);

    final region = WorldMapController.calculateCombinedRegion(countries);

    return FittedBox(
      child: SizedBox(
        width: region.width * 4.3 + 20,
        height: region.height * 4.3 + 20,
        child: Stack(
          children: countries.isEmpty
              ? []
              : WorldMapController.fromCountryList(
                  countries,
                  shadow: true,
                  onSelect: (country) => notifier.select(country),
                  offset: Offset(-region.left, -region.top),
                ),
        ),
      ),
    );
  }
}

class TestWorldMap extends ConsumerWidget {
  const TestWorldMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FittedBox(
      child: WorldMap(
        onSelect: (country) {
          ref.read(WorldMapController.selectedCountries.notifier).select(country);
        },
      ),
    );
  }
}
