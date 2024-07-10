import 'package:flutter/material.dart';
import 'package:moveeasy/State/auth_provider.dart';
import 'package:provider/provider.dart';

class VerifyMobilePage extends StatelessWidget {
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
                'Verify Your Mobile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Please enter the 4-digit code you received to the given mobile number, and enter the boxes below.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextField(
                      onChanged: (value) {
                        if (value.length == 1) {
                          authProvider.setVerificationCode(
                              authProvider.verificationCode + value);
                          if (index < 3) {
                            FocusScope.of(context).nextFocus();
                          }
                        }
                      },
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  
                  authProvider
                      .verifyCode(); // Call verifyCode method from AuthProvider
                },
                child: Text('VERIFY'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.yellow, // Customize button color if needed
                  foregroundColor:
                      Colors.black, // Customize text color if needed
                  minimumSize: Size(double.infinity, 50), // Button size
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Code Not Received? Resent in a 90s',
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(height: 20),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Mobile Number Wrong? Back To "),
                    GestureDetector(
                      onTap: () {
                        // Handle back to sign up navigation
                        Navigator.pop(context);
                      },
                      child: Text(
                        'SignUp',
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
