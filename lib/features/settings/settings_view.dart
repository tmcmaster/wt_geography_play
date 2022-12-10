import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_geography_play/features/navigate_between/NavigateBetweenSettinga.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Settings Page',
              style: TextStyle(fontSize: 36),
            ),
            ApplicationSettings.theme.component,
            ApplicationSettings.colorScheme.component,
            // ApplicationSettings.debugMode.component,
            // ApplicationSettings.applicationType.component,
            NavigateBetweenSettings.multiplayerMode.component,
          ],
        ),
      ),
    );
  }
}
