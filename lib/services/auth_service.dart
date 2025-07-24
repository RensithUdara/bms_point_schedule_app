import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService {
  static const String _userKey = 'current_user';
  
  // Hardcoded login for testing
  static const String _testEmail = 'admin@gmail.com';
  static const String _testPassword = '@Admin123';

  Future<User?> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    if (email == _testEmail && password == _testPassword) {
      final user = User(
        id: '1',
        email: email,
        name: 'Admin User',
        role: 'Administrator',
        profileImage: null,
        lastLogin: DateTime.now(),
      );
      
      // Save user to local storage
      await _saveUser(user);
      return user;
    }
    
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  Future<User?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);
      
      if (userJson != null) {
        final Map<String, dynamic> userMap = json.decode(userJson);
        return User.fromJson(userMap);
      }
    } catch (e) {
      // Handle error
    }
    
    return null;
  }

  Future<void> _saveUser(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = json.encode(user.toJson());
      await prefs.setString(_userKey, userJson);
    } catch (e) {
      // Handle error
    }
  }
}
