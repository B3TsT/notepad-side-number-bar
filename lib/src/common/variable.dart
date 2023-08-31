import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

import '../core/utils/intent_class.dart';

String image =
    'https://docs.microsoft.com/en-us/windows/uwp/design/controls-and-patterns/images/navview-freeform-header-top.png';

String titleFuentApp = 'Fluent UI Demo';
String labelDarkMode = 'Dark Mode';
String todoPaneItem = 'List Todo';
String settingsPaneItem = 'Settings';

Map<ShortcutActivator, Intent> shortcut = {
  LogicalKeySet(LogicalKeyboardKey.keyI, LogicalKeyboardKey.controlLeft):
      const NavigationListIntent(),
  LogicalKeySet(LogicalKeyboardKey.keyS, LogicalKeyboardKey.controlLeft):
      const NavigationSettingsIntent(),
};
