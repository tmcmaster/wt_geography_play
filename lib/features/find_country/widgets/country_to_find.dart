import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/find_country/providers/next_country_to_find.dart';

class CountryToFind extends ConsumerWidget {
  const CountryToFind({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nextCountry = ref.watch(nextCountryToFind);
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Text(
        'Find: $nextCountry',
        style: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 24,
        ),
      ),
    );
  }
}
