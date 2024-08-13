import 'package:flutter/material.dart';
import 'package:moveeasy/Service/api_service.dart';
import 'package:moveeasy/Service/auth_storage.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  String _name = '';
  String _email = '';
  String _mobile = '';
  String _password = '';
  String _passwordConfirmation = '';
  String _verificationCode = '';
  String _token = '';
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String _error = '';
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isGuest = false;
  
  

  String get name => _name;
  String get email => _email;
  String get phoneNumber => _mobile;
  String get password => _password;
  String get passwordConfirmation => _passwordConfirmation;
  String get verificationCode => _verificationCode;
  bool get isLoading => _isLoading;
  String get error => _error;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  String get token => _token;
  bool get isAuthenticated => _isAuthenticated;
  bool get isGuest => _isGuest;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setMobile(String mobile) {
    _mobile = mobile;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setPasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    notifyListeners();
  }

  void setVerificationCode(String code) {
    _verificationCode = code;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  void continueAsGuest() {
    _isAuthenticated = false;
    _isGuest = true;
    notifyListeners();
  }



  Future<void> checkAuthStatus() async {
    final token = await _apiService.getStoredToken();
    if (token != null) {
      _token = token;
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  Future<void> initializeAuth() async {
    final storedToken = await AuthStorage.getToken();
    if (storedToken != null && storedToken.isNotEmpty) {
      _token = storedToken;
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  //Register
  Future<bool> signUp() async {
  _isLoading = true;
  _error = '';
  notifyListeners();

  try {
    _token = await _apiService.register(_name, _mobile, _password, _passwordConfirmation);
    _isAuthenticated = true;
    _isLoading = false;
    notifyListeners();
    return true;
  } catch (e) {
    print('Error signing up: $e');
    _error = 'Registration failed. Please check your information and try again.';
    _isLoading = false;
    _isAuthenticated = false;
    notifyListeners();
    return false;
  }
}



  //SignIn
  Future<bool> signIn() async {
  _isLoading = true;
  _error = '';
  notifyListeners();

  try {
    _token = await _apiService.login(_mobile, _password);
    _isAuthenticated = true;
    _isLoading = false;
    notifyListeners();
    return true;
  } catch (e) {
    print('Error signing in: $e');
    _error = 'Login failed. Please check your credentials and try again.';
    _isLoading = false;
    _isAuthenticated = true;
    notifyListeners();
    return false;
  }
}


  Future<void> signOut(BuildContext context) async {
    await _apiService.logout();
    _token = '';
    _isAuthenticated = false;
    notifyListeners();
    Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (route) => false);
  }

  Future<void> resetPassword(BuildContext context) async {
    try {
      bool success = await _apiService.forgotPasswordReset(_mobile);
      if (success) {
        // Password reset initiated successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password reset link sent to your phone number')),
        );
        Navigator.pushNamed(context, '/recovery-code');
      }
    } catch (e) {
      print('Error initiating password reset: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to initiate password reset. Please try again.')),
      );
    }
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
