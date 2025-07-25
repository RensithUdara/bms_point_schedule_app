import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/settings_controller.dart';
import '../widgets/settings_overview.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SettingsController>().loadSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF1E40AF),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<SettingsController>(
        builder: (context, settingsController, child) {
          if (settingsController.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF8FAFC), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Settings Overview Widget
                  const SettingsOverview(),

                  // Quick Actions
                  const SettingsQuickActions(),

                  const SizedBox(height: 24),

                  // Appearance Section
                  _buildSettingsSection(
                    title: 'Appearance',
                    icon: Icons.palette_rounded,
                    children: [
                      _buildSwitchTile(
                        title: 'Dark Mode',
                        subtitle: 'Switch between light and dark theme',
                        icon: Icons.dark_mode_rounded,
                        value: settingsController.isDarkMode,
                        onChanged: (value) {
                          settingsController.setDarkMode(value);
                        },
                      ),
                      _buildDropdownTile(
                        title: 'Theme Color',
                        subtitle: 'Choose your preferred accent color',
                        icon: Icons.color_lens_rounded,
                        value: settingsController.themeColor,
                        items: const [
                          'Blue',
                          'Green',
                          'Purple',
                          'Orange',
                          'Red',
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            settingsController.setThemeColor(value);
                          }
                        },
                      ),
                    ],
                  ),

                  // Notifications Section
                  _buildSettingsSection(
                    title: 'Notifications',
                    icon: Icons.notifications_rounded,
                    children: [
                      _buildSwitchTile(
                        title: 'Push Notifications',
                        subtitle: 'Receive push notifications',
                        icon: Icons.notifications_active_rounded,
                        value: settingsController.pushNotificationsEnabled,
                        onChanged: (value) {
                          settingsController.setPushNotifications(value);
                        },
                      ),
                      _buildSwitchTile(
                        title: 'Equipment Alerts',
                        subtitle: 'Get alerts for equipment status changes',
                        icon: Icons.warning_rounded,
                        value: settingsController.equipmentAlertsEnabled,
                        onChanged: (value) {
                          settingsController.setEquipmentAlerts(value);
                        },
                      ),
                      _buildSwitchTile(
                        title: 'Maintenance Reminders',
                        subtitle: 'Receive maintenance schedule reminders',
                        icon: Icons.schedule_rounded,
                        value: settingsController.maintenanceRemindersEnabled,
                        onChanged: (value) {
                          settingsController.setMaintenanceReminders(value);
                        },
                      ),
                    ],
                  ),

                  // Data & Storage Section
                  _buildSettingsSection(
                    title: 'Data & Storage',
                    icon: Icons.storage_rounded,
                    children: [
                      _buildSwitchTile(
                        title: 'Auto Sync',
                        subtitle: 'Automatically sync data when connected',
                        icon: Icons.sync_rounded,
                        value: settingsController.autoSyncEnabled,
                        onChanged: (value) {
                          settingsController.setAutoSync(value);
                        },
                      ),
                      _buildSwitchTile(
                        title: 'Offline Mode',
                        subtitle: 'Allow app to work without internet',
                        icon: Icons.offline_bolt_rounded,
                        value: settingsController.offlineModeEnabled,
                        onChanged: (value) {
                          settingsController.setOfflineMode(value);
                        },
                      ),
                      _buildActionTile(
                        title: 'Clear Cache',
                        subtitle: 'Free up space by clearing cached data',
                        icon: Icons.cleaning_services_rounded,
                        onTap: () {
                          _showClearCacheDialog(context, settingsController);
                        },
                      ),
                    ],
                  ),

                  // Security Section
                  _buildSettingsSection(
                    title: 'Security',
                    icon: Icons.security_rounded,
                    children: [
                      _buildSwitchTile(
                        title: 'Biometric Authentication',
                        subtitle: 'Use fingerprint or face recognition',
                        icon: Icons.fingerprint_rounded,
                        value: settingsController.biometricAuthEnabled,
                        onChanged: (value) {
                          settingsController.setBiometricAuth(value);
                        },
                      ),
                      _buildDropdownTile(
                        title: 'Auto Lock',
                        subtitle: 'Automatically lock the app after inactivity',
                        icon: Icons.lock_clock_rounded,
                        value: settingsController.autoLockDuration,
                        items: const [
                          'Never',
                          '1 minute',
                          '5 minutes',
                          '15 minutes',
                          '30 minutes',
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            settingsController.setAutoLockDuration(value);
                          }
                        },
                      ),
                      _buildActionTile(
                        title: 'Change Password',
                        subtitle: 'Update your account password',
                        icon: Icons.lock_reset_rounded,
                        onTap: () {
                          _showChangePasswordDialog(context);
                        },
                      ),
                    ],
                  ),

                  // Language & Region Section
                  _buildSettingsSection(
                    title: 'Language & Region',
                    icon: Icons.language_rounded,
                    children: [
                      _buildDropdownTile(
                        title: 'Language',
                        subtitle: 'Choose your preferred language',
                        icon: Icons.translate_rounded,
                        value: settingsController.selectedLanguage,
                        items: const [
                          'English',
                          'Sinhala',
                          'Tamil',
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            settingsController.setLanguage(value);
                          }
                        },
                      ),
                      _buildDropdownTile(
                        title: 'Date Format',
                        subtitle: 'Select date display format',
                        icon: Icons.calendar_today_rounded,
                        value: settingsController.dateFormat,
                        items: const [
                          'DD/MM/YYYY',
                          'MM/DD/YYYY',
                          'YYYY/MM/DD',
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            settingsController.setDateFormat(value);
                          }
                        },
                      ),
                    ],
                  ),

                  // About Section
                  _buildSettingsSection(
                    title: 'About',
                    icon: Icons.info_rounded,
                    children: [
                      _buildInfoTile(
                        title: 'App Version',
                        subtitle: '1.0.0+1',
                        icon: Icons.info_outline_rounded,
                      ),
                      _buildActionTile(
                        title: 'Privacy Policy',
                        subtitle: 'Read our privacy policy',
                        icon: Icons.privacy_tip_rounded,
                        onTap: () {
                          _showPrivacyPolicyDialog(context);
                        },
                      ),
                      _buildActionTile(
                        title: 'Terms of Service',
                        subtitle: 'Read our terms of service',
                        icon: Icons.description_rounded,
                        onTap: () {
                          _showTermsOfServiceDialog(context);
                        },
                      ),
                      _buildActionTile(
                        title: 'Send Feedback',
                        subtitle: 'Help us improve the app',
                        icon: Icons.feedback_rounded,
                        onTap: () {
                          _showFeedbackDialog(context);
                        },
                      ),
                    ],
                  ),

                  // Danger Zone
                  _buildSettingsSection(
                    title: 'Danger Zone',
                    icon: Icons.warning_rounded,
                    children: [
                      _buildActionTile(
                        title: 'Reset Settings',
                        subtitle: 'Reset all settings to default values',
                        icon: Icons.restore_rounded,
                        onTap: () {
                          _showResetSettingsDialog(context, settingsController);
                        },
                        textColor: Colors.orange,
                      ),
                      _buildActionTile(
                        title: 'Delete Account',
                        subtitle: 'Permanently delete your account',
                        icon: Icons.delete_forever_rounded,
                        onTap: () {
                          _showDeleteAccountDialog(context);
                        },
                        textColor: Colors.red,
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF3B82F6),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
          ...children,
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF6B7280),
            size: 20,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1F2937),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF3B82F6),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF6B7280),
            size: 20,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1F2937),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          DropdownButton<String>(
            value: value,
            onChanged: onChanged,
            underline: const SizedBox(),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Icon(
                icon,
                color: textColor ?? const Color(0xFF6B7280),
                size: 20,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: textColor ?? const Color(0xFF1F2937),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF6B7280),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF6B7280),
            size: 20,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1F2937),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog(
      BuildContext context, SettingsController settingsController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear Cache'),
          content: const Text(
            'This will clear all cached data and may temporarily slow down the app. Continue?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                settingsController.clearCache();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cache cleared successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final TextEditingController currentPasswordController =
        TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement password change logic here
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password changed successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Change'),
            ),
          ],
        );
      },
    );
  }

  void _showPrivacyPolicyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Privacy Policy'),
          content: const SingleChildScrollView(
            child: Text(
              'This is a placeholder for the privacy policy. '
              'In a real app, you would include your actual privacy policy here '
              'or navigate to a web view showing the policy.',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showTermsOfServiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Terms of Service'),
          content: const SingleChildScrollView(
            child: Text(
              'This is a placeholder for the terms of service. '
              'In a real app, you would include your actual terms of service here '
              'or navigate to a web view showing the terms.',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    final TextEditingController feedbackController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send Feedback'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  'We value your feedback! Please let us know how we can improve.'),
              const SizedBox(height: 16),
              TextField(
                controller: feedbackController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Your feedback',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement feedback submission logic here
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Feedback sent successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }

  void _showResetSettingsDialog(
      BuildContext context, SettingsController settingsController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset Settings'),
          content: const Text(
            'This will reset all settings to their default values. This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                settingsController.resetSettings();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Settings reset to default'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
            'This will permanently delete your account and all associated data. '
            'This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement account deletion logic here
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Account deletion requested'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
