import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class AuthService {
  static const String _userKey = 'current_user';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> login(String email, String password) async {
    try {
      // Query Firestore for user with matching email
      final QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception('User not found with this email address');
      }

      final DocumentSnapshot userDoc = querySnapshot.docs.first;
      final Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      
      // Check password (in a real app, you'd use proper password hashing)
      final String storedPassword = userData['password'] ?? '';
      if (storedPassword != password) {
        throw Exception('Incorrect password. Please try again.');
      }

      // Check if user is active
      final bool isActive = userData['is_active'] ?? false;
      if (!isActive) {
        throw Exception('ACCOUNT_DEACTIVATED:Your account has been deactivated. Please contact the administrator for assistance.');
      }

      // Create user object
      final user = User(
        id: userDoc.id,
        email: userData['email'],
        name: userData['name'] ?? '',
        role: userData['role'] ?? 'User',
        profileImage: userData['profileImage'],
        lastLogin: DateTime.now(),
        isActive: isActive,
      );

      // Update last login time in Firestore
      await _firestore.collection('users').doc(userDoc.id).update({
        'lastLogin': FieldValue.serverTimestamp(),
      });

      // Save user to local storage
      await _saveUser(user);
      return user;
    } on FirebaseException catch (e) {
      throw Exception('Firebase error: ${e.message}');
    } catch (e) {
      rethrow;
    }
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

  // Helper method to check if a user exists and is active
  Future<bool> isUserActiveByEmail(String email) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return false;
      }

      final DocumentSnapshot userDoc = querySnapshot.docs.first;
      final Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      
      return userData['is_active'] ?? false;
    } catch (e) {
      return false;
    }
  }
}
