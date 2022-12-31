import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_geography_play/features/find_country/find_country_app.dart';

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
