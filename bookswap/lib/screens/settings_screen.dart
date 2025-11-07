import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/my_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationReminders = true;
  bool emailUpdates = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Settings'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Profile Picture
              CircleAvatar(
                radius: 50,
                backgroundColor: AppTheme.yellowAccent,
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              // Name
              const Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              // Email
              Text(
                'john.doe@example.com',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              // Profile Options
              _buildProfileOption(
                icon: Icons.edit,
                title: 'Edit Profile',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _buildProfileOption(
                icon: Icons.book,
                title: 'My Books',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _buildProfileOption(
                icon: Icons.favorite,
                title: 'Favorites',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _buildProfileOption(
                icon: Icons.history,
                title: 'Swap History',
                onTap: () {},
              ),
              const SizedBox(height: 32),
              // Settings Section
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text(
                  'Notification reminders',
                  style: TextStyle(color: Colors.black),
                ),
                value: notificationReminders,
                onChanged: (v) => setState(() => notificationReminders = v),
                activeColor: AppTheme.yellowAccent,
                contentPadding: EdgeInsets.zero,
              ),
              SwitchListTile(
                title: const Text(
                  'Email Updates',
                  style: TextStyle(color: Colors.black),
                ),
                value: emailUpdates,
                onChanged: (v) => setState(() => emailUpdates = v),
                activeColor: AppTheme.yellowAccent,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'About',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Logout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppTheme.navyBlue,
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
