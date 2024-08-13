import 'package:flutter/material.dart';
import 'package:moveeasy/Pages/sign_up_page.dart';
import 'package:moveeasy/Provider/auth_provider.dart';
import 'package:moveeasy/components/sign_in_button.dart';
import 'package:moveeasy/components/video_header.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Sign In'),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () {
      //       // Add back button functionality if needed
      //     },
      //   ),
      // ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              VideoHeader(), // Add image
              SizedBox(height: 20),
              Text(
                'Sign In',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Rent a Vehicle Or Rent Your vehicle',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) => authProvider.setMobile(value),
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  hintText: 'Enter your mobile number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) => authProvider.setPassword(value),
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      authProvider.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      authProvider.togglePasswordVisibility();
                    },
                  ),
                ),
                obscureText: !authProvider.isPasswordVisible,
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: false,
                    onChanged: (bool? value) {
                      // Handle remember me functionality
                    },
                  ),
                  Text('Remember me'),
                ],
              ),
              SizedBox(height: 10),


              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/forgot-password');
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 10),
              
              SignInButton(), // Use the button

              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      // Handle sign up navigation
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      ); // Navigate to the sign-up page
                    },
                    child: Text('Sign Up'),
                  ),
                  
                ],
              ),
              // SizedBox(),
            TextButton(
              child: Text('or continue as a guest'),
              onPressed: () {
                authProvider.continueAsGuest();
                Navigator.pushReplacementNamed(context, '/main-navigation');
              },
            ),
            ],
          ),
        ),
      ),
    );
  }
}
