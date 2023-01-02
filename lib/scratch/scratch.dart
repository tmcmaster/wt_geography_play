import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/world_map/widgets/world_map.dart';

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
      home: const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8),
            // child: ExploreMapApp(),
            child: TestShapeWidget(),
          ),
        ),
      ),
    );
  }
}

class TestShapeWidget extends ConsumerWidget {
  const TestShapeWidget({super.key});

  static const australiaOffset = Offset(-290, -100);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryMap = ref.watch(WorldMap.countryMap);
    final asia = countryMap.values.where((country) => country.continent == 'Asia').toList();

    final notifier = ref.read(WorldMap.selectedCountries.notifier);

    return Stack(
      children: asia.isEmpty
          ? []
          : WorldMap.fromCountryList(
              asia,
              shadow: true,
              offset: const Offset(-210, -30),
              onSelect: (country) => notifier.select(country),
            ),
    );
  }
}

class TestWorldMap extends ConsumerWidget {
  const TestWorldMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WorldMap(
      onSelect: (country) {
        ref.read(WorldMap.selectedCountries.notifier).select(country);
      },
    );
  }
}
