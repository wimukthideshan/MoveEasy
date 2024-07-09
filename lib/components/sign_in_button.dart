import 'package:flutter/material.dart';
import 'package:moveeasy/State/auth_provider.dart';
import 'package:provider/provider.dart';


class SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return ElevatedButton(
      onPressed: () {
        authProvider.signIn();
      },
      child: Text('SIGN IN'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
        minimumSize: Size(double.infinity, 50),
      ),
    );
  }
}
