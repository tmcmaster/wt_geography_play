import 'package:wt_settings/wt_settings.dart';

abstract class NavigateBetweenSettings {
  static final multiplayerMode = SettingsBoolProviders(
    key: '__NAVIGATE_BETWEEN_MULTIPLAYER',
    label: "Multiplayer",
    hint: "Enable multiplayer mode.",
  );
}
