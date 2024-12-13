// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sample/shared_perferences';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => UserSettingsProvider(),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UserSettingsProvider>(
//       builder: (context, settings, child) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: settings.darkMode ? ThemeData.dark() : ThemeData.light(),
//           home: const HomeScreen(),
//         );
//       },
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final settingsProvider = Provider.of<UserSettingsProvider>(context);

//     return Scaffold(
//       appBar: AppBar(title: const Text("User Settings")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               decoration: const InputDecoration(labelText: 'Username'),
//               onChanged: (value) {
//                 settingsProvider.setUsername(value);
//               },
//               controller:
//                   TextEditingController(text: settingsProvider.username),
//             ),
//             SwitchListTile(
//               title: const Text("Dark Mode"),
//               value: settingsProvider.darkMode,
//               onChanged: (value) {
//                 settingsProvider.toggleDarkMode(value);
//               },
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                     "Notification Count: ${settingsProvider.notificationCount}"),
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.remove),
//                       onPressed: () {
//                         settingsProvider.updateNotificationCount(
//                           settingsProvider.notificationCount > 0
//                               ? settingsProvider.notificationCount - 1
//                               : 0,
//                         );
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.add),
//                       onPressed: () {
//                         settingsProvider.updateNotificationCount(
//                           settingsProvider.notificationCount + 1,
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// -----------------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ToggleState(),
      child: const HelloApp(),
    ),
  );
}

class HelloApp extends StatelessWidget {
  const HelloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ToggleState>(
      builder: (context, toggleState, child) {
        return MaterialApp(
          theme: toggleState.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          debugShowCheckedModeBanner: false,
          home: const Homepage(),
        );
      },
    );
  }
}

class ToggleState extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _isNotificationOn = false;
  String _username = "";

  bool get isDarkMode => _isDarkMode;
  bool get isNotificationOn => _isNotificationOn;
  String get username => _username;

  ToggleState() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('darkMode') ?? false;
    _isNotificationOn = prefs.getBool('notification') ?? false;
    _username = prefs.getString('username') ?? "";
    notifyListeners(); // Notify listeners after loading preferences
  }

  Future<void> _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _isDarkMode);
    await prefs.setBool('notification', _isNotificationOn);
    await prefs.setString('username', _username);
  }

  void toggleDarkMode(bool value) {
    _isDarkMode = value;
    _savePreferences();
    notifyListeners(); // Notify listeners when dark mode state changes
  }

  void toggleNotification(bool value) {
    _isNotificationOn = value;
    _savePreferences();
    notifyListeners(); // Notify listeners when notification state changes
  }

  void updateUsername(String value) {
    _username = value;
    _savePreferences();
    notifyListeners(); // Notify listeners when the username changes
  }
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final toggleState = Provider.of<ToggleState>(context);
    TextEditingController usernameController =
        TextEditingController(text: toggleState.username);

    return Scaffold(
      backgroundColor: toggleState.isDarkMode
          ? Colors.grey[900]
          : const Color.fromARGB(255, 207, 242, 31),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 100),
            ),
            // DARK MODE SWITCH
            Container(
              height: 60,
              width: 400,
              decoration: BoxDecoration(
                color: toggleState.isDarkMode
                    ? const Color.fromARGB(255, 56, 51, 51)
                    : Colors.black,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: toggleState.isDarkMode
                      ? Colors.white
                      : const Color.fromARGB(255, 57, 7, 206), // Border color
                  width: 2, // Border width
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "DARK MODE",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Switch(
                    value: toggleState.isDarkMode,
                    onChanged: (value) {
                      toggleState.toggleDarkMode(value);
                    },
                    activeColor: Colors.blue,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.white,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),
            // NOTIFICATION SWITCH
            Container(
              height: 60,
              width: 400,
              decoration: BoxDecoration(
                color: toggleState.isDarkMode
                    ? const Color.fromARGB(255, 56, 51, 51)
                    : Colors.black,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: toggleState.isDarkMode
                      ? Colors.white
                      : const Color.fromARGB(255, 54, 4, 218),
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "NOTIFICATION",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Switch(
                    value: toggleState.isNotificationOn,
                    onChanged: (value) {
                      toggleState.toggleNotification(value);
                    },
                    activeColor: Colors.blue,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.white,
                  ),
                ],
              ),
            ),

            const Spacer(),
            // Username TextField with SharedPreferences
            Container(
              height: 60,
              width: 350,
              decoration: BoxDecoration(
                color: toggleState.isDarkMode
                    ? const Color.fromARGB(255, 49, 48, 50)
                    : Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: const Color.fromARGB(255, 33, 7, 224),
                  width: 2,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: usernameController,
                      style: TextStyle(
                        color: toggleState.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                      decoration: const InputDecoration(
                        hintText: "Enter Username",
                      ),
                      onChanged: (value) {
                        toggleState.updateUsername(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
