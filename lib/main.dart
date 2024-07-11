import 'package:flutter/material.dart';
import 'package:moveeasy/Pages/forgot_password_page.dart';
import 'package:moveeasy/Pages/home_page.dart';
import 'package:moveeasy/Pages/recovery_code_page.dart';
import 'package:moveeasy/Pages/reset_password_page.dart';
import 'package:moveeasy/State/auth_provider.dart';
import 'package:moveeasy/navigation/navigation_service.dart';
import 'package:moveeasy/pages/sign_in_page.dart';
import 'package:moveeasy/pages/sign_up_page.dart';
import 'package:moveeasy/pages/verify_mobile_page.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NavigationService _navigationService = NavigationService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        Provider<NavigationService>(create: (_) => _navigationService),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MoveEasy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: _navigationService.navigatorKey,
        home: SignInPage(),
        routes: {
          '/sign-in': (context) => SignInPage(),
          '/sign-up': (context) => SignUpPage(),
          '/verify-mobile': (context) => VerifyMobilePage(),
          '/forgot-password': (context) => ForgotPasswordPage(),
          '/home': (context) => HomePage(),
          '/reset-password': (context) => ResetPasswordPage(),
          '/recovery-code': (context) => RecoveryCodePage(),
        },
      ),
    );
  }
}
