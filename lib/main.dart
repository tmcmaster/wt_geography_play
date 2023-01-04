import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_geography_play/apps/explore_map/explore_map_app.dart';
import 'package:wt_geography_play/apps/find_country/find_country_app.dart';
import 'package:wt_geography_play/apps/find_dinosaurs/find_dinosaurs_app.dart';
import 'package:wt_geography_play/apps/navigate_between/navigate_between_app.dart';
import 'package:wt_geography_play/firebase_options.dart';

void main() async {
  runMyApp(
    withFirebase(
      andAppScaffold(
          appDetails: appDetails,
          appDefinition: appDefinition,
          loginSupport: const LoginSupport(
            googleEnabled: true,
            emailEnabled: true,
          )),
      appName: 'wt-geography-play',
      firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    ),
  );
}

final appDetails = Provider<AppDetails>(
  name: 'AppDefinition',
  (ref) => AppDetails(
    title: 'Geography Play',
    subTitle: 'Explore your interests',
    iconPath: 'assets/wt_logo_3.png',
  ),
);

final appDefinition = Provider<AppDefinition>(
  name: 'AppDefinition',
  (ref) => AppDefinition.from(
    appName: 'geography-play',
    appTitle: 'Geography Play',
    includeAppBar: false,
    swipeEnabled: false,
    pages: [
      PageDefinition(
        title: 'Find Dinosaurs',
        icon: FontAwesomeIcons.magnifyingGlass,
        builder: (context) => const FindDinosaursApp(),
        primary: true,
      ),
      PageDefinition(
        title: 'Explore Map',
        icon: Icons.explore,
        builder: (context) => const ExploreMapApp(),
        primary: true,
      ),
      PageDefinition(
        title: 'Navigate Between',
        icon: Icons.navigation_rounded,
        builder: (context) => const NavigateBetweenApp(),
        primary: true,
      ),
      PageDefinition(
        title: 'Find Country',
        icon: Icons.find_in_page,
        builder: (context) => const FindCountryApp(),
        primary: true,
      ),
      PageDefinition(
        title: 'Settings',
        icon: Icons.settings,
        builder: (context) => const SettingsPage(),
        primary: true,
      ),
    ],
  ),
);
