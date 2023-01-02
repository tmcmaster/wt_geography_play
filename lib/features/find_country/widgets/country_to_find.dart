import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/find_country/find_country_controller.dart';

class CountryToFind extends ConsumerWidget {
  final FindCountryController controller;

  const CountryToFind({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryToFind = ref.watch(controller.state).countryToFind;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Text(
        'Find: $countryToFind',
        style: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 24,
        ),
      ),
    );
  }
}
