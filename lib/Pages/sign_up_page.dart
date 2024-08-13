import 'package:flutter/material.dart';
import 'package:moveeasy/Provider/auth_provider.dart';
import 'package:moveeasy/components/sign_up_button.dart';
import 'package:moveeasy/components/video_header.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Sign Up'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                VideoHeader(), // Add your image here
                SizedBox(height: 20),
                Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Create an account to rent a vehicle or rent your vehicle',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                // TextField(
                //   onChanged: (value) => authProvider.setPhoneNumber(value),
                //   decoration: InputDecoration(
                //     labelText: 'Phone Number',
                //     hintText: 'Enter your phone number',
                //     border: OutlineInputBorder(),
                //   ),
                // ),

                TextField(
                    onChanged: (value) => authProvider.setName(value),
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      border: OutlineInputBorder(),
                    ),
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
                SizedBox(height: 20),
                TextField(
                  onChanged: (value) => authProvider.setPasswordConfirmation(value),
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter your password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        authProvider.isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        authProvider.toggleConfirmPasswordVisibility();
                      },
                    ),
                  ),
                  obscureText: !authProvider.isConfirmPasswordVisible,
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: false,
                      onChanged: (bool? value) {
                        // Handle agree to terms functionality
                      },
                    ),
                    Text('Agree to terms and conditions'),
                  ],
                ),
                SizedBox(height: 20),


                //signup button
                SignUpButton(),

                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/sign-in'); // Navigate to sign-in page
                      },
                      child:
                          Text('Sign In', style: TextStyle(color: Colors.blue)),
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
