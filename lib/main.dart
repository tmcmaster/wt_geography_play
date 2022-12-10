import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_geography_play/apps/navigate_between.dart';
import 'package:wt_geography_play/features/settings/settings_view.dart';
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
    pages: [
      PageDefinition(
        title: 'Navigate Between',
        icon: Icons.map,
        builder: (context) => const NavigateBetween(),
        primary: true,
      ),
      PageDefinition(
        title: 'Settings',
        icon: Icons.settings,
        builder: (context) => const SettingsView(),
        primary: true,
      ),
    ],
  ),
);
