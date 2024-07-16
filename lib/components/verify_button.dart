import 'package:flutter/material.dart';
import 'package:moveeasy/Provider/auth_provider.dart';
import 'package:provider/provider.dart';

class VerifyButton extends StatelessWidget {
  final VoidCallback? onVerified; // Add callback

  VerifyButton({this.onVerified});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return ElevatedButton(
      onPressed: () async {
        bool success = await authProvider.verifyCode(context); // Await the result
        if (success && onVerified != null) {
          onVerified!(); // Call the callback if verification is successful
        } else {
          // Handle verification failure if needed (e.g., show a snackbar)
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Verification failed'),
          ));
        }
      },
      child: Text('VERIFY'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
        minimumSize: Size(double.infinity, 50),
      ),
    );
  }
}
