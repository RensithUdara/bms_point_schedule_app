import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends ChangeNotifier {
  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Appearance settings
  bool _isDarkMode = false;
  String _themeColor = 'Blue';

  // Notification settings
  bool _pushNotificationsEnabled = true;
  bool _equipmentAlertsEnabled = true;
  bool _maintenanceRemindersEnabled = true;

  // Data & Storage settings
  bool _autoSyncEnabled = true;
  bool _offlineModeEnabled = false;

  // Security settings
  bool _biometricAuthEnabled = false;
  String _autoLockDuration = '15 minutes';

  // Language & Region settings
  String _selectedLanguage = 'English';
  String _dateFormat = 'DD/MM/YYYY';

  // Getters for all settings
  bool get isDarkMode => _isDarkMode;
  String get themeColor => _themeColor;
  bool get pushNotificationsEnabled => _pushNotificationsEnabled;
  bool get equipmentAlertsEnabled => _equipmentAlertsEnabled;
  bool get maintenanceRemindersEnabled => _maintenanceRemindersEnabled;
  bool get autoSyncEnabled => _autoSyncEnabled;
  bool get offlineModeEnabled => _offlineModeEnabled;
  bool get biometricAuthEnabled => _biometricAuthEnabled;
  String get autoLockDuration => _autoLockDuration;
  String get selectedLanguage => _selectedLanguage;
  String get dateFormat => _dateFormat;

  // Settings keys for SharedPreferences
  static const String _keyDarkMode = 'dark_mode';
  static const String _keyThemeColor = 'theme_color';
  static const String _keyPushNotifications = 'push_notifications';
  static const String _keyEquipmentAlerts = 'equipment_alerts';
  static const String _keyMaintenanceReminders = 'maintenance_reminders';
  static const String _keyAutoSync = 'auto_sync';
  static const String _keyOfflineMode = 'offline_mode';
  static const String _keyBiometricAuth = 'biometric_auth';
  static const String _keyAutoLockDuration = 'auto_lock_duration';
  static const String _keySelectedLanguage = 'selected_language';
  static const String _keyDateFormat = 'date_format';

  // Load settings from SharedPreferences
  Future<void> loadSettings() async {
    _setLoading(true);

    try {
      final prefs = await SharedPreferences.getInstance();

      _isDarkMode = prefs.getBool(_keyDarkMode) ?? false;
      _themeColor = prefs.getString(_keyThemeColor) ?? 'Blue';
      _pushNotificationsEnabled = prefs.getBool(_keyPushNotifications) ?? true;
      _equipmentAlertsEnabled = prefs.getBool(_keyEquipmentAlerts) ?? true;
      _maintenanceRemindersEnabled =
          prefs.getBool(_keyMaintenanceReminders) ?? true;
      _autoSyncEnabled = prefs.getBool(_keyAutoSync) ?? true;
      _offlineModeEnabled = prefs.getBool(_keyOfflineMode) ?? false;
      _biometricAuthEnabled = prefs.getBool(_keyBiometricAuth) ?? false;
      _autoLockDuration = prefs.getString(_keyAutoLockDuration) ?? '15 minutes';
      _selectedLanguage = prefs.getString(_keySelectedLanguage) ?? 'English';
      _dateFormat = prefs.getString(_keyDateFormat) ?? 'DD/MM/YYYY';

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading settings: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Save individual setting methods
  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    notifyListeners();
    await _saveBoolSetting(_keyDarkMode, value);
  }

  Future<void> setThemeColor(String value) async {
    _themeColor = value;
    notifyListeners();
    await _saveStringSetting(_keyThemeColor, value);
  }

  Future<void> setPushNotifications(bool value) async {
    _pushNotificationsEnabled = value;
    notifyListeners();
    await _saveBoolSetting(_keyPushNotifications, value);
  }

  Future<void> setEquipmentAlerts(bool value) async {
    _equipmentAlertsEnabled = value;
    notifyListeners();
    await _saveBoolSetting(_keyEquipmentAlerts, value);
  }

  Future<void> setMaintenanceReminders(bool value) async {
    _maintenanceRemindersEnabled = value;
    notifyListeners();
    await _saveBoolSetting(_keyMaintenanceReminders, value);
  }

  Future<void> setAutoSync(bool value) async {
    _autoSyncEnabled = value;
    notifyListeners();
    await _saveBoolSetting(_keyAutoSync, value);
  }

  Future<void> setOfflineMode(bool value) async {
    _offlineModeEnabled = value;
    notifyListeners();
    await _saveBoolSetting(_keyOfflineMode, value);
  }

  Future<void> setBiometricAuth(bool value) async {
    _biometricAuthEnabled = value;
    notifyListeners();
    await _saveBoolSetting(_keyBiometricAuth, value);
  }

  Future<void> setAutoLockDuration(String value) async {
    _autoLockDuration = value;
    notifyListeners();
    await _saveStringSetting(_keyAutoLockDuration, value);
  }

  Future<void> setLanguage(String value) async {
    _selectedLanguage = value;
    notifyListeners();
    await _saveStringSetting(_keySelectedLanguage, value);
  }

  Future<void> setDateFormat(String value) async {
    _dateFormat = value;
    notifyListeners();
    await _saveStringSetting(_keyDateFormat, value);
  }

  // Utility methods
  Future<void> clearCache() async {
    try {
      // In a real app, you would clear actual cache data here
      // For now, we'll just simulate the action
      await Future.delayed(const Duration(milliseconds: 500));
      debugPrint('Cache cleared');
    } catch (e) {
      debugPrint('Error clearing cache: $e');
    }
  }

  Future<void> resetSettings() async {
    _setLoading(true);

    try {
      final prefs = await SharedPreferences.getInstance();

      // Clear all settings from SharedPreferences
      await prefs.remove(_keyDarkMode);
      await prefs.remove(_keyThemeColor);
      await prefs.remove(_keyPushNotifications);
      await prefs.remove(_keyEquipmentAlerts);
      await prefs.remove(_keyMaintenanceReminders);
      await prefs.remove(_keyAutoSync);
      await prefs.remove(_keyOfflineMode);
      await prefs.remove(_keyBiometricAuth);
      await prefs.remove(_keyAutoLockDuration);
      await prefs.remove(_keySelectedLanguage);
      await prefs.remove(_keyDateFormat);

      // Reset to default values
      _isDarkMode = false;
      _themeColor = 'Blue';
      _pushNotificationsEnabled = true;
      _equipmentAlertsEnabled = true;
      _maintenanceRemindersEnabled = true;
      _autoSyncEnabled = true;
      _offlineModeEnabled = false;
      _biometricAuthEnabled = false;
      _autoLockDuration = '15 minutes';
      _selectedLanguage = 'English';
      _dateFormat = 'DD/MM/YYYY';

      notifyListeners();
    } catch (e) {
      debugPrint('Error resetting settings: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> _saveBoolSetting(String key, bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(key, value);
    } catch (e) {
      debugPrint('Error saving bool setting $key: $e');
    }
  }

  Future<void> _saveStringSetting(String key, String value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
    } catch (e) {
      debugPrint('Error saving string setting $key: $e');
    }
  }

  // Method to get theme color as a Color object
  static Color getThemeColorValue(String colorName) {
    switch (colorName) {
      case 'Blue':
        return const Color(0xFF3B82F6);
      case 'Green':
        return const Color(0xFF10B981);
      case 'Purple':
        return const Color(0xFF8B5CF6);
      case 'Orange':
        return const Color(0xFFF59E0B);
      case 'Red':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF3B82F6); // Default to blue
    }
  }

  // Method to get auto lock duration in minutes
  static int getAutoLockDurationMinutes(String duration) {
    switch (duration) {
      case 'Never':
        return -1;
      case '1 minute':
        return 1;
      case '5 minutes':
        return 5;
      case '15 minutes':
        return 15;
      case '30 minutes':
        return 30;
      default:
        return 15; // Default to 15 minutes
    }
  }

  // Method to format date according to selected format
  static String formatDate(DateTime date, String format) {
    switch (format) {
      case 'DD/MM/YYYY':
        return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
      case 'MM/DD/YYYY':
        return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
      case 'YYYY/MM/DD':
        return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
      default:
        return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    }
  }
}
