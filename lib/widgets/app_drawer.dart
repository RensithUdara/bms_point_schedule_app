import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/auth_controller.dart';
import '../views/about_us_screen.dart';
import '../views/contact_us_screen.dart';
import '../views/profile_screen.dart';
import '../views/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8FAFC), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Drawer Header
            Consumer<AuthController>(
              builder: (context, authController, child) {
                final user = authController.currentUser;
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            user?.name.substring(0, 1).toUpperCase() ?? 'U',
                            style: const TextStyle(
                              color: Color(0xFF1E40AF),
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user?.name ?? 'User',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.email ?? '',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Menu Items
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    // Dashboard
                    _buildMenuItem(
                      icon: Icons.dashboard_rounded,
                      title: 'Dashboard',
                      onTap: () {
                        Navigator.pop(context);
                      },
                      isSelected: true,
                    ),

                    const SizedBox(height: 8),

                    // Profile
                    _buildMenuItem(
                      icon: Icons.person_rounded,
                      title: 'Profile',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 8),

                    // About Us
                    _buildMenuItem(
                      icon: Icons.info_rounded,
                      title: 'About Us',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutUsScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 8),

                    // Contact Us
                    _buildMenuItem(
                      icon: Icons.contact_support_rounded,
                      title: 'Contact Us',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ContactUsScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 8),

                    // Settings
                    _buildMenuItem(
                      icon: Icons.settings_rounded,
                      title: 'Settings',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsScreen(),
                          ),
                        );
                      },
                    ),

                    const Spacer(),

                    // Logout
                    Consumer<AuthController>(
                      builder: (context, authController, child) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                Navigator.pop(context);
                                _showLogoutDialog(context, authController);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF2F2),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(0xFFFECACA),
                                    width: 1,
                                  ),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.logout_rounded,
                                      color: Color(0xFFDC2626),
                                      size: 24,
                                    ),
                                    SizedBox(width: 16),
                                    Text(
                                      'Logout',
                                      style: TextStyle(
                                        color: Color(0xFFDC2626),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF1E40AF).withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? const Color(0xFF1E40AF)
                      : const Color(0xFF6B7280),
                  size: 24,
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected
                        ? const Color(0xFF1E40AF)
                        : const Color(0xFF374151),
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthController authController) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Logout',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              authController.logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Logout',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
