// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart'; // Import the constants file

class LoginProvider with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    const url = "${Constants.baseUrl}Login"; // Use baseUrl from constants

    try {
      final Map<String, dynamic> logindata = {
        "username": username,
        "password": password,
      };
      final response = await http.post(
        Uri.parse(url),
        body: logindata,
      );

      _isLoading = false;
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status']) {
          // Login successful
          await _saveLoginData(data);
          return true;
        } else {
          // Login failed
          _errorMessage = data['message'];
        }
      } else {
        // API failure
        _errorMessage = response.statusCode.toString();
      }
    } catch (e) {
      _errorMessage = 'An error occurred. Please check your connection.';
    }

    notifyListeners();
    return false;
  }

  Future<void> _saveLoginData(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save the token
    prefs.setString('token', data['token']);

    // Save user details
    if (data['user_details'] != null) {
      prefs.setInt('user_id', data['user_details']['id']);
      prefs.setString('user_name', data['user_details']['name']);
      prefs.setString('user_email', data['user_details']['mail']);
      prefs.setString('user_phone', data['user_details']['phone']);
      prefs.setString('user_username', data['user_details']['username']);
      prefs.setBool('is_admin', data['user_details']['is_admin'] ?? false);
    }
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('user_id');
    prefs.remove('user_name');
    prefs.remove('user_email');
    prefs.remove('user_phone');
    prefs.remove('user_username');
    prefs.remove('is_admin');
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token != null; // Return true if token is found
  }
}
