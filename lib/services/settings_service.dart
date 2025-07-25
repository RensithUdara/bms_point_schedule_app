import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class SettingsService {
  static const String _keyAppVersion = 'app_version';
  static const String _keyFirstRun = 'first_run';
  static const String _keyLastSyncTime = 'last_sync_time';
  static const String _keyUserPreferences = 'user_preferences';

  // Get app version
  static Future<String> getAppVersion() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_keyAppVersion) ?? '1.0.0+1';
    } catch (e) {
      debugPrint('Error getting app version: $e');
      return '1.0.0+1';
    }
  }

  // Set app version
  static Future<void> setAppVersion(String version) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyAppVersion, version);
    } catch (e) {
      debugPrint('Error setting app version: $e');
    }
  }

  // Check if this is the first run
  static Future<bool> isFirstRun() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_keyFirstRun) ?? true;
    } catch (e) {
      debugPrint('Error checking first run: $e');
      return true;
    }
  }

  // Set first run flag
  static Future<void> setFirstRun(bool isFirstRun) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyFirstRun, isFirstRun);
    } catch (e) {
      debugPrint('Error setting first run: $e');
    }
  }

  // Get last sync time
  static Future<DateTime?> getLastSyncTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timestamp = prefs.getInt(_keyLastSyncTime);
      if (timestamp != null) {
        return DateTime.fromMillisecondsSinceEpoch(timestamp);
      }
      return null;
    } catch (e) {
      debugPrint('Error getting last sync time: $e');
      return null;
    }
  }

  // Set last sync time
  static Future<void> setLastSyncTime(DateTime time) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_keyLastSyncTime, time.millisecondsSinceEpoch);
    } catch (e) {
      debugPrint('Error setting last sync time: $e');
    }
  }

  // Clear all settings and cache
  static Future<void> clearAllData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      debugPrint('All settings and cache cleared');
    } catch (e) {
      debugPrint('Error clearing all data: $e');
    }
  }

  // Get storage usage information
  static Future<Map<String, dynamic>> getStorageInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();

      return {
        'totalKeys': keys.length,
        'estimatedSize': _estimateStorageSize(prefs, keys),
        'lastCleared': await getLastSyncTime(),
      };
    } catch (e) {
      debugPrint('Error getting storage info: $e');
      return {
        'totalKeys': 0,
        'estimatedSize': 0,
        'lastCleared': null,
      };
    }
  }

  // Export settings as JSON
  static Future<Map<String, dynamic>> exportSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      final Map<String, dynamic> settings = {};

      for (final key in keys) {
        final value = prefs.get(key);
        settings[key] = value;
      }

      return settings;
    } catch (e) {
      debugPrint('Error exporting settings: $e');
      return {};
    }
  }

  // Import settings from JSON
  static Future<bool> importSettings(Map<String, dynamic> settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      for (final entry in settings.entries) {
        final key = entry.key;
        final value = entry.value;

        if (value is bool) {
          await prefs.setBool(key, value);
        } else if (value is int) {
          await prefs.setInt(key, value);
        } else if (value is double) {
          await prefs.setDouble(key, value);
        } else if (value is String) {
          await prefs.setString(key, value);
        } else if (value is List<String>) {
          await prefs.setStringList(key, value);
        }
      }

      return true;
    } catch (e) {
      debugPrint('Error importing settings: $e');
      return false;
    }
  }

  // Private helper method to estimate storage size
  static int _estimateStorageSize(SharedPreferences prefs, Set<String> keys) {
    int totalSize = 0;

    for (final key in keys) {
      final value = prefs.get(key);

      // Rough estimation of storage size
      totalSize += key.length; // Key size

      if (value is String) {
        totalSize += value.length;
      } else if (value is List<String>) {
        for (final item in value) {
          totalSize += item.length;
        }
      } else {
        totalSize += 8; // Approximate size for primitives
      }
    }

    return totalSize;
  }

  // Backup user preferences
  static Future<void> backupUserPreferences(
      Map<String, dynamic> preferences) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json =
          preferences.toString(); // In a real app, use proper JSON encoding
      await prefs.setString(_keyUserPreferences, json);
    } catch (e) {
      debugPrint('Error backing up user preferences: $e');
    }
  }

  // Restore user preferences
  static Future<Map<String, dynamic>?> restoreUserPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_keyUserPreferences);
      if (json != null) {
        // In a real app, use proper JSON decoding
        return {'restored': true}; // Placeholder
      }
      return null;
    } catch (e) {
      debugPrint('Error restoring user preferences: $e');
      return null;
    }
  }

  // Check if settings need migration
  static Future<bool> needsSettingsMigration() async {
    try {
      final currentVersion = await getAppVersion();
      // Compare with a stored version to determine if migration is needed
      // This is a simplified example
      return currentVersion == '1.0.0+1';
    } catch (e) {
      debugPrint('Error checking settings migration: $e');
      return false;
    }
  }

  // Perform settings migration
  static Future<void> migrateSettings() async {
    try {
      // Implement migration logic here
      // This could include converting old setting formats to new ones
      await setAppVersion('1.0.0+1');
      debugPrint('Settings migration completed');
    } catch (e) {
      debugPrint('Error during settings migration: $e');
    }
  }
}
