import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _phoneNumber = '';
  String _password = '';

  String get phoneNumber => _phoneNumber;
  String get password => _password;

  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void signIn() {
    // Add your sign-in logic here
    print('Signing in with phone number $_phoneNumber and password $_password');
  }
}
