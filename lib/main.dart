import 'package:flutter/material.dart';
import 'package:moveeasy/Pages/vehicle_details_page.dart';
import 'package:moveeasy/Provider/auth_provider.dart';
import 'package:moveeasy/Provider/navigation_state_provider.dart';
import 'package:moveeasy/Provider/search_provider.dart';
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
import 'package:moveeasy/pages/search_page.dart';
import 'package:moveeasy/navigation/custom_route_observer.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CustomRouteObserver routeObserver = CustomRouteObserver();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NavigationStateProvider()),
        ChangeNotifierProvider(create: (_) => VehicleProvider()),
        ChangeNotifierProvider(create: (_) => VehicleDataService()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        Provider<CustomRouteObserver>.value(value: routeObserver),
        Provider<GlobalKey<NavigatorState>>(create: (_) => navigatorKey),
        Provider<NavigationService>(create: (_) => NavigationService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MoveEasy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: navigatorKey,
        navigatorObservers: [routeObserver],
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
          '/search': (context) => SearchPage(),
        },
      ),
    );
  }
}
