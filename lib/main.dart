import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sihapp/HomeScreen.dart';
import 'package:sihapp/Login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that Flutter is initialized.
  await Firebase.initializeApp(); // Initialize Firebase.

  // Check user login state
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MaterialApp(
    title: 'My App',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    initialRoute: isLoggedIn ? '/home' : '/login', // Set initial route based on login state
    routes: {
      '/login': (context) => LoginScreen(),
      '/home': (context) => HomeScreen(),
    },
  ));
}
