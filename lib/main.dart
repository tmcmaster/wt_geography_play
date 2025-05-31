import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_platform/scaffold_app_dsl.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/page_info.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_geography_play/apps/explore_map/explore_map_app.dart';
import 'package:wt_geography_play/apps/find_country/find_country_app.dart';
import 'package:wt_geography_play/apps/find_dinosaurs/find_dinosaurs_app.dart';
import 'package:wt_geography_play/apps/navigate_between/navigate_between_app.dart';
import 'package:wt_geography_play/firebase_options.dart';

void main() async {
  runMyApp(
    withFirebase(
      andFirebaseLogin(
        andAppScaffold(
          appDetails: appDetails,
          appDefinition: appDefinition,
          appStyles: SharedAppConfig.styles,
        ),
        emailEnabled: true,
      ),
      database: true,
      appName: 'wt-geography-play',
      firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    ),
  );
}

final appDetails = AppDetails(
  title: 'Geography Play',
  subTitle: 'Explore your interests',
  iconPath: 'assets/wt_logo_3.png',
);

final appDefinition = AppDefinition.from(
  appName: 'geography-play',
  appTitle: 'Geography Play',
  includeAppBar: false,
  swipeEnabled: false,
  pages: [
    PageDefinition(
      pageInfo: const PageInfo(
        name: 'findDinosaur',
        title: 'Find Dinosaurs',
        tabTitle: 'Find Dinosaurs',
        icon: FontAwesomeIcons.magnifyingGlass,
      ),
      pageBuilder: (context) => const FindDinosaursApp(),
      primary: true,
    ),
    PageDefinition(
      pageInfo: const PageInfo(
        name: 'exploreMap',
        title: 'Explore Map',
        icon: Icons.explore,
      ),
      pageBuilder: (context) => const ExploreMapApp(),
      primary: true,
    ),
    PageDefinition(
      pageInfo: const PageInfo(
        name: 'navigateBetween',
        title: 'Navigate Between',
        icon: Icons.navigation_rounded,
      ),
      pageBuilder: (context) => const NavigateBetweenApp(),
      primary: true,
    ),
    PageDefinition(
      pageInfo: const PageInfo(
        name: 'findCountry',
        title: 'Find Country',
        icon: Icons.find_in_page,
      ),
      pageBuilder: (context) => const FindCountryApp(),
      primary: true,
    ),
    // TODO: Need to implement this game.
    PageDefinition(
      pageInfo: const PageInfo(
        name: 'guessCountry',
        title: 'Guess Country',
        icon: Icons.find_in_page,
      ),
      pageBuilder: (context) => const ExploreMapApp(),
      primary: true,
    ),
    PageDefinition(
      pageInfo: const PageInfo(
        name: 'settings',
        title: 'Settings',
        icon: Icons.settings,
      ),
      pageBuilder: (context) => const SettingsPage(),
      primary: true,
    ),
  ],
);
