import 'package:flutter/material.dart';
import 'package:moveeasy/Pages/favourites_page.dart';
import 'package:moveeasy/Pages/vehicle_details_page.dart';
import 'package:moveeasy/Provider/auth_provider.dart';
import 'package:moveeasy/Provider/navigation_state_provider.dart';
import 'package:moveeasy/Provider/user_provider.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';
import 'package:moveeasy/Service/vehicle_data_service.dart';
import 'package:moveeasy/navigation/main_navigation_page.dart';
import 'package:moveeasy/Service/navigation_service.dart';
import 'package:moveeasy/pages/forgot_password_page.dart';
import 'package:moveeasy/pages/home_page.dart';
import 'package:moveeasy/pages/recovery_code_page.dart';
import 'package:moveeasy/pages/reset_password_page.dart';
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
        ChangeNotifierProvider(create: (_) => NavigationStateProvider()),
        ChangeNotifierProvider(create: (_) => VehicleProvider()),
        ChangeNotifierProvider(create: (_) => VehicleDataService()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MoveEasy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: _navigationService.navigatorKey,
        initialRoute: '/sign-in', // Set initial route here
        home: MainNavigationPage(),
        routes: {
          '/sign-in': (context) => SignInPage(),
          '/sign-up': (context) => SignUpPage(),
          '/verify-mobile': (context) => VerifyMobilePage(),
          '/forgot-password': (context) => ForgotPasswordPage(),
          '/home': (context) => HomePage(),
          '/reset-password': (context) => ResetPasswordPage(),
          '/recovery-code': (context) => RecoveryCodePage(),
          '/main-navigation': (context) => MainNavigationPage(),
          '/vehicle-details': (context) => VehicleDetailsPage(vehicleIndex: 0),
        },
      ),
    );
  }
}
