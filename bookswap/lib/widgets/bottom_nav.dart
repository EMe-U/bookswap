import 'package:flutter/material.dart';
import '../screens/welcome_screen.dart';
import '../screens/browse_screen.dart';
import '../screens/post_book_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/settings_screen.dart';
import '../theme/app_theme.dart';

class BottomNavController extends StatefulWidget {
  final bool startWithBrowse;
  
  const BottomNavController({Key? key, this.startWithBrowse = false}) : super(key: key);

  @override
  _BottomNavControllerState createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  late int _bottomNavIndex; // -1 means showing welcome screen, 0-2 for bottom nav
  late bool _hasLeftWelcome;

  @override
  void initState() {
    super.initState();
    // If we should start with browse screen, set the state accordingly
    if (widget.startWithBrowse) {
      _hasLeftWelcome = true;
      _bottomNavIndex = 0; // Home (Browse) is index 0
    } else {
      _hasLeftWelcome = false;
      _bottomNavIndex = -1;
    }
  }

  final List<Widget> _screens = [
    WelcomeScreen(),
    BrowseScreen(),
    PostBookScreen(),
    ChatScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Show welcome screen initially (only if not starting with browse)
    if (!_hasLeftWelcome && !widget.startWithBrowse) {
      return _screens[0];
    }

    // Map bottom nav indices to screen indices
    // Bottom nav: 0=Home (Browse), 1=My Listings (Post), 2=Chats (Chat), 3=Settings
    // Screens: 0=Welcome, 1=Browse, 2=Post, 3=Chat, 4=Settings
    final screenIndex = _bottomNavIndex == 0
        ? 1
        : (_bottomNavIndex == 1
            ? 2
            : (_bottomNavIndex == 2 ? 3 : 4));

    return Scaffold(
      body: _screens[screenIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppTheme.navyBlue,
        ),
        child: SafeArea(
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.menu_book, 'Home', 0),
                _buildNavItem(Icons.bolt, 'My Listings', 1),
                _buildNavItem(Icons.chat_bubble_outline, 'Chats', 2),
                _buildNavItem(Icons.settings, 'Settings', 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _bottomNavIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _hasLeftWelcome = true;
          _bottomNavIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? AppTheme.yellowAccent : Colors.white,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppTheme.yellowAccent : Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
