import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wt_geography_play/models/country.dart';

// final countriesProvider = FutureProvider<List<Country>>((ref) async {
//   String jsonString = await rootBundle.loadString('assets/countries.json');
//   final List<dynamic> jsonObject = json.decode(jsonString);
//   return jsonObject.map((j) => Country.fromJson(j)).toList();
// });
//
// final countriesNameMapProvider =
//     FutureProvider<Map<String, Country>>((ref) async {
//   return ref.read(countriesProvider).when(
//         data: (data) => {for (var c in data) c.name: c},
//         error: (error, __) =>
//             {'error': Country(id: 'Error', name: error.toString())},
//         loading: () => {'loading': Country(id: 'a', name: 'AA')},
//       );
// });
//

final countryListProvider2 =
    StateNotifierProvider<CountryListNotifier, List<Country>>((ref) => CountryListNotifier());

class CountryListNotifier extends StateNotifier<List<Country>> {
  CountryListNotifier() : super([]) {
    rootBundle.loadString('assets/data/countries.json').then((jsonString) {
      final List<dynamic> jsonObject = json.decode(jsonString);
      state = jsonObject.map((j) => Country.fromJson(j)).toList();
    });
  }
}

final countryLookupProvider2 = StateNotifierProvider<CountryLookupNotifier, Map<String, Country>>(
    (ref) => CountryLookupNotifier(ref));

class CountryLookupNotifier extends StateNotifier<Map<String, Country>> {
  CountryLookupNotifier(Ref ref) : super({}) {
    ref.listen(countryListProvider2, (_, next) {
      state = {for (var c in next) c.name: c};
    });
  }
}

final distanceNotifierProvider =
    StateNotifierProvider<DistanceStateNotifier, double>((ref) => DistanceStateNotifier(ref));

class DistanceStateNotifier extends StateNotifier<double> {
  final Ref ref;
  DistanceStateNotifier(this.ref) : super(0);

  void reset() {
    state = 0;
  }

  void addDistance(Country from, Country to) {
    final countryLookup = ref.read(countryLookupProvider2);

    final fromCountry = countryLookup[from.name];
    final toCountry = countryLookup[to.name];

    if (fromCountry != null && toCountry != null) {
      print('From: $fromCountry');
      print('To: $toCountry');

      final double fromLat = fromCountry.latitude.toDouble();
      final double fromLng = fromCountry.longitude.toDouble();
      final double toLat = toCountry.latitude.toDouble();
      final double toLng = toCountry.longitude.toDouble();

      if (fromLat != 0 && fromLng != 0 && toLat != 0 && toLng != 0) {
        final distance = Geolocator.distanceBetween(fromLat, fromLng, toLat, toLng);
        state += distance;
      } else {
        print('Missing some location data');
      }
    } else {
      print('Missing some location data');
    }
  }
}
