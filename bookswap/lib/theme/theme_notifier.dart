import 'package:flutter/material.dart';

/// A simple global theme notifier so parts of the app can toggle ThemeMode.
class ThemeNotifier extends ValueNotifier<ThemeMode> {
  ThemeNotifier(ThemeMode value) : super(value);

  void toggle() {
    value = value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}

/// Global instance used by the app. Initialized to dark to keep current behavior.
final ThemeNotifier themeNotifier = ThemeNotifier(ThemeMode.dark);
