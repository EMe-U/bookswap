import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'theme/theme_notifier.dart';
import 'widgets/bottom_nav.dart';

void main() {
  runApp(BookSwapApp());
}

class BookSwapApp extends StatelessWidget {
  const BookSwapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'BookSwap',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: mode,
          home: BottomNavController(),
        );
      },
    );
  }
}
