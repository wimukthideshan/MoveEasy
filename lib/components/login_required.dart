import 'package:flutter/material.dart';

class LoginRequiredWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to MoveEasy, You have not logged in.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Please log in to access this page',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Sign In',
            style: TextStyle(
              fontSize:18,
              fontWeight: FontWeight.bold,
              color:  Colors.white), textAlign: TextAlign.center,),
            onPressed: () {
              Navigator.pushNamed(context, '/sign-in');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber[800],
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}