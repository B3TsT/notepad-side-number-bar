import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

class NavigationPaneOnchangedPeople {
  static updateSelectedIndex({
    required int selectedIndex,
    required int value,
  }) {
    LogicalKeySet(LogicalKeyboardKey.keyU);
    const SingleActivator(LogicalKeyboardKey.keyX, control: true);
    return selectedIndex = value;
  }
}
