import 'package:flutter/material.dart';
import 'package:moveeasy/Pages/sign_in_page.dart';
import 'package:moveeasy/State/auth_provider.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vehicle Rental App',
      home: SignInPage(),
    );
  }
}
