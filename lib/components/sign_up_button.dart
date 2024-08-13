// lib/components/sign_up_button.dart

import 'package:flutter/material.dart';
import 'package:moveeasy/Provider/auth_provider.dart';
import 'package:provider/provider.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final navigatorKey = Provider.of<GlobalKey<NavigatorState>>(context, listen: false);

    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return ElevatedButton(
          onPressed: authProvider.isLoading
              ? null
              : () async {
                  try {
                    final success = await authProvider.signUp();
                    if (success) {
                      navigatorKey.currentState?.pushReplacementNamed('/verify-mobile');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(authProvider.error)),
                      );
                    }
                  } catch (e) {
                    print('Error during sign up: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('An unexpected error occurred. Please try again.')),
                    );
                  }
                },
          child: authProvider.isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                )
              : Text('SIGN UP'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
            minimumSize: Size(double.infinity, 50),
          ),
        );
      },
    );
  }
}