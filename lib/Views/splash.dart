// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shihas_noviindus/Views/login.dart';
import 'package:shihas_noviindus/Views/patientList.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to login page after 3 seconds
    // Timer(const Duration(seconds: 3), () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => LoginPage()),
    //   );
    // });

    _navigateToNextScreen();
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print("-------------------------------");
    print(token);
    return token != null; // Return true if token is found
  }

  Future<void> _navigateToNextScreen() async {
    bool loggedIn = await isLoggedIn();

    Timer(const Duration(seconds: 3), () {
      if (loggedIn) {
        // Navigate to HomePage if logged in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PatientList()),
        );
      } else {
        // Navigate to LoginPage if not logged in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgImage.png'), // Background image
            fit: BoxFit.cover, // Fills the screen
          ),
        ),
      ),
    );
  }
}
