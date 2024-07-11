import 'package:flutter/material.dart';
import 'package:moveeasy/State/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:moveeasy/components/verify_button.dart'; // Import the VerifyButton
import 'package:moveeasy/components/update_password_button.dart'; // Import the UpdatePasswordButton

class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/vehicle.gif'), // Add your image here
              SizedBox(height: 20),
              Text(
                'Reset Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Text(
              //   'Please enter the 4-digit code you received to the given mobile number, and enter the boxes below.',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(fontSize: 16),
              // ),
              // SizedBox(height: 20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: List.generate(4, (index) {
              //     return SizedBox(
              //       width: 50,
              //       child: TextField(
              //         onChanged: (value) {
              //           if (value.length == 1) {
              //             authProvider.setVerificationCode(
              //                 authProvider.verificationCode + value);
              //             if (index < 3) {
              //               FocusScope.of(context).nextFocus();
              //             }
              //           }
              //         },
              //         textAlign: TextAlign.center,
              //         keyboardType: TextInputType.number,
              //         maxLength: 1,
              //         decoration: InputDecoration(
              //           counterText: "",
              //           border: OutlineInputBorder(),
              //         ),
              //       ),
              //     );
              //   }),
              // ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) => authProvider.setPassword(value),
                decoration: InputDecoration(
                  labelText: 'Your New Password',
                  hintText: 'Enter your new password',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) => authProvider.setConfirmPassword(value),
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              // VerifyButton(),
              SizedBox(height: 20),
              UpdatePasswordButton(), // Use the button
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Remember the password? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/sign-in');
                      },
                      child: Text(
                        'Back To Sign in',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
