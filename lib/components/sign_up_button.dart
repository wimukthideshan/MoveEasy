import 'package:flutter/material.dart';
import 'package:moveeasy/State/auth_provider.dart';
import 'package:provider/provider.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return ElevatedButton(
      onPressed: () {
        authProvider.signUp(context); // Pass the BuildContext here
        Navigator.pushNamed(context, '/verify-mobile');
      },
      child: Text('Register'), // Match the text to the SignInButton
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow, // Button color
        foregroundColor: Colors.black, // Text color
        minimumSize: Size(double.infinity, 50), // Button size
      ),
    );
  }
}
