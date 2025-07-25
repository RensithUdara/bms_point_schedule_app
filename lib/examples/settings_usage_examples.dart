import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/settings_controller.dart';
import '../utils/theme_manager.dart';

/// Example widget showing how to use settings throughout the app
class SettingsAwareWidget extends StatelessWidget {
  const SettingsAwareWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsController>(
      builder: (context, settings, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: settings.isDarkMode ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Example of using theme color
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: SettingsController.getThemeColorValue(
                      settings.themeColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 12),

              // Example of using theme-aware text
              Text(
                'Settings-Aware Content',
                style: ThemeManager.getHeadlineTextStyle(settings.isDarkMode),
              ),

              const SizedBox(height: 8),

              // Example of conditional content based on settings
              if (settings.pushNotificationsEnabled)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.notifications_active,
                        color: Colors.green,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Notifications Enabled',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 12),

              // Example of using date format setting
              Text(
                'Current Date: ${SettingsController.formatDate(DateTime.now(), settings.dateFormat)}',
                style: ThemeManager.getSubtitleTextStyle(settings.isDarkMode),
              ),

              // Example of using language setting
              Text(
                'Language: ${settings.selectedLanguage}',
                style: ThemeManager.getSubtitleTextStyle(settings.isDarkMode),
              ),

              // Example of showing auto-lock duration
              Text(
                'Auto-lock: ${settings.autoLockDuration}',
                style: ThemeManager.getSubtitleTextStyle(settings.isDarkMode),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Example of how to modify settings programmatically
class SettingsUsageExample {
  static void exampleUsage(BuildContext context) {
    final settings = context.read<SettingsController>();

    // Toggle dark mode
    settings.setDarkMode(!settings.isDarkMode);

    // Change theme color
    settings.setThemeColor('Green');

    // Enable notifications
    settings.setPushNotifications(true);

    // Set language
    settings.setLanguage('Sinhala');

    // Example of conditional logic based on settings
    if (settings.offlineModeEnabled) {
      // Handle offline functionality
      print('App is in offline mode');
    }

    if (settings.autoSyncEnabled) {
      // Trigger auto-sync
      print('Auto-sync is enabled');
    }
  }
}

/// Example of theme-aware custom widget
class ThemedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ThemedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsController>(
      builder: (context, settings, child) {
        final themeColor =
            SettingsController.getThemeColorValue(settings.themeColor);

        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: themeColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(text),
        );
      },
    );
  }
}

/// Example of settings-aware notification helper
class NotificationHelper {
  static bool shouldShowNotification(SettingsController settings, String type) {
    // Check global notification setting
    if (!settings.pushNotificationsEnabled) {
      return false;
    }

    // Check specific notification types
    switch (type) {
      case 'equipment_alert':
        return settings.equipmentAlertsEnabled;
      case 'maintenance_reminder':
        return settings.maintenanceRemindersEnabled;
      default:
        return true;
    }
  }

  static void showSettingsAwareNotification(
    BuildContext context,
    String message,
    String type,
  ) {
    final settings = context.read<SettingsController>();

    if (shouldShowNotification(settings, type)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor:
              SettingsController.getThemeColorValue(settings.themeColor),
        ),
      );
    }
  }
}

/// Example of settings-aware data formatting
class DataFormatter {
  static String formatDateWithSettings(
      DateTime date, SettingsController settings) {
    return SettingsController.formatDate(date, settings.dateFormat);
  }

  static String getLocalizedText(String key, SettingsController settings) {
    // This would typically use a localization package
    switch (settings.selectedLanguage) {
      case 'Sinhala':
        return _getSinhalaText(key);
      case 'Tamil':
        return _getTamilText(key);
      default:
        return _getEnglishText(key);
    }
  }

  static String _getEnglishText(String key) {
    final texts = {
      'welcome': 'Welcome',
      'settings': 'Settings',
      'dashboard': 'Dashboard',
    };
    return texts[key] ?? key;
  }

  static String _getSinhalaText(String key) {
    final texts = {
      'welcome': 'ආයුබෝවන්',
      'settings': 'සැකසුම්',
      'dashboard': 'පාලක පුවරුව',
    };
    return texts[key] ?? key;
  }

  static String _getTamilText(String key) {
    final texts = {
      'welcome': 'வணக்கம்',
      'settings': 'அமைப்புகள்',
      'dashboard': 'டாஷ்போர்டு',
    };
    return texts[key] ?? key;
  }
}
