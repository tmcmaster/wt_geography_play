import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_geography_play/features/navigate_between/NavigateBetweenSettinga.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      children: [
        NavigateBetweenSettings.multiplayerMode.component,
      ],
    );
  }
}
