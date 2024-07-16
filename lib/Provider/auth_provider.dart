import 'package:flutter/material.dart';
import 'package:moveeasy/Service/navigation_service.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  String _phoneNumber = '';
  String _password = '';
  String _confirmPassword = '';
  String _verificationCode = '';

  String get phoneNumber => _phoneNumber;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String get verificationCode => _verificationCode;

  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  void setVerificationCode(String code) {
    _verificationCode = code;
    notifyListeners();
  }

  void signUp(BuildContext context) {
    print('Sign Up with Phone: $_phoneNumber, Password: $_password');
    if (_password == _confirmPassword) {
      print('Passwords match. Proceeding with sign-up.');
      final navigationService = Provider.of<NavigationService>(context, listen: false);
      navigationService.navigateTo('/verify-mobile');
    } else {
      print('Passwords do not match. Please re-enter.');
    }
  }

  void signIn(BuildContext context) {
    print('Signing in with phone number $_phoneNumber and password $_password');
    Navigator.pushReplacementNamed(context, '/main-navigation');
  }

  void signOut(BuildContext context) {
    // Clear user data, tokens, etc.
    Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (route) => false);
  }

  void resetPassword(BuildContext context) {
    // calling backend API to initiate the password reset
    print('Initiating password reset for phone number: $_phoneNumber');
  }

  Future<bool> verifyCode(BuildContext context) async {
    // assuming verification is always successful
    bool isVerified = true; // Example check

    if (isVerified) {
      _verificationCode = ''; // Reset the code after successful verification
      return true;
    } 
    return false;
    
  }
}
