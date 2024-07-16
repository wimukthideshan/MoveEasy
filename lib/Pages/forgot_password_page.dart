import 'package:flutter/material.dart';
import 'package:moveeasy/Provider/auth_provider.dart';
import 'package:provider/provider.dart';


class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                Image.asset('assets/vehicle.gif'), // Replace with your ice cream truck image
                SizedBox(height: 20),
                Text(
                  'Forget Password',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Please enter your registered mobile number to reset your password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged: (value) => authProvider.setPhoneNumber(value),
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    hintText: 'Enter your phone number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle password reset verification
                    Navigator.pushNamed(context, '/recovery-code');
                    authProvider
                      .resetPassword(context);
                  },
                  child: Text('Send Recovery Code'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Remember the password?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Go back to sign in page
                      },
                      child: Text('Back To Sign in', style: TextStyle(color: Colors.amber)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}