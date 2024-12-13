// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserSettingsProvider with ChangeNotifier {
//   String _username = '';
//   bool _darkMode = false;
//   int _notificationCount = 0;

//   String get username => _username;
//   bool get darkMode => _darkMode;
//   int get notificationCount => _notificationCount;

//   UserSettingsProvider() {
//     _loadPreferences();
//   }

//   // Load preferences
//   Future<void> _loadPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     _username = prefs.getString('username') ?? '';
//     _darkMode = prefs.getBool('darkMode') ?? false;
//     _notificationCount = prefs.getInt('notificationCount') ?? 0;
//     notifyListeners();
//   }

//   // Save preferences
//   Future<void> savePreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('username', _username);
//     await prefs.setBool('darkMode', _darkMode);
//     await prefs.setInt('notificationCount', _notificationCount);
//     notifyListeners();
//   }

//   // Setters to update preferences
//   void setUsername(String username) {
//     _username = username;
//     savePreferences();
//   }

//   void toggleDarkMode(bool isDarkMode) {
//     _darkMode = isDarkMode;
//     savePreferences();
//   }

//   void updateNotificationCount(int count) {
//     _notificationCount = count;
//     savePreferences();
//   }
// }

// ignore_for_file: override_on_non_overriding_member

// -----------------------------------------------------------------------------------
// import 'package:sample/main.dart';

// class homepagestate extends state<hompage> {
//   bool darkmode = false;
//   bool notification = false;

//    @override
//   void initState() {
//     super.initState();
   
//     _loadPreferences();
//   }
// }

