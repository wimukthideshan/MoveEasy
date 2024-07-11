import 'package:flutter/material.dart';
import 'package:moveeasy/Pages/reset_password_page.dart';
import 'package:moveeasy/Pages/sign_in_page.dart';
import 'package:moveeasy/State/auth_provider.dart';
import 'package:provider/provider.dart';

class UpdatePasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return ElevatedButton(
      onPressed: () {
        // Simulate setting new password (replace with actual logic)
        authProvider.setPassword('new_password');

        // Navigate to reset password page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInPage()),
        );
      },
      child: Text('Update Password'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
        minimumSize: Size(double.infinity, 50),
      ),
    );
  }
}
