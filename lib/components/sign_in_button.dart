// lib/components/sign_in_button.dart

import 'package:flutter/material.dart';
import 'package:moveeasy/Provider/auth_provider.dart';
import 'package:provider/provider.dart';

class SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigatorKey = Provider.of<GlobalKey<NavigatorState>>(context, listen: false);
    
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return ElevatedButton(
          onPressed: authProvider.isLoading
              ? null
              : () async {
                  final success = await authProvider.signIn();
                  if (success) {
                    navigatorKey.currentState?.pushReplacementNamed('/main-navigation');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(authProvider.error)),
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
              : Text('SIGN IN'),
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