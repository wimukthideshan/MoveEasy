import 'package:flutter/material.dart';
import 'package:moveeasy/Pages/add_vehicle_page.dart';
import 'package:moveeasy/Pages/favourites_page.dart';
import 'package:moveeasy/Pages/home_page.dart';
import 'package:moveeasy/Pages/my_profile_page.dart';
import 'package:moveeasy/State/navigation_state_provider.dart';
import 'package:moveeasy/navigation/navigation_bar.dart';
import 'package:provider/provider.dart';

class MainNavigationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavigationStateProvider(),
      child: Consumer<NavigationStateProvider>(
        builder: (context, navigationStateProvider, _) => Scaffold(
          body: Navigator(
            key: navigationStateProvider.navigatorKey,
            onGenerateRoute: (settings) {
              WidgetBuilder builder;
              switch (settings.name) {
                case '/':
                  builder = (_) => HomePage();
                  break;
                case '/add_vehicle':
                  builder = (_) => AddVehiclePage();
                  break;
                case '/favorites':
                  builder = (_) => FavoritesPage();
                  break;
                case '/my_profile':
                  builder = (_) => MyProfilePage();
                  break;
                default:
                  throw Exception('Invalid route: ${settings.name}');
              }
              return MaterialPageRoute(builder: builder, settings: settings);
            },
          ),
          bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: navigationStateProvider.selectedIndex,
            onItemTapped: (index) {
              navigationStateProvider.setSelectedIndex(index);
              switch (index) {
                case 0:
                  navigationStateProvider.navigatorKey.currentState!.pushReplacementNamed('/');
                  break;
                case 1:
                  navigationStateProvider.navigatorKey.currentState!.pushReplacementNamed('/add_vehicle');
                  break;
                case 2:
                  navigationStateProvider.navigatorKey.currentState!.pushReplacementNamed('/favorites');
                  break;
                case 3:
                  navigationStateProvider.navigatorKey.currentState!.pushReplacementNamed('/my_profile');
                  break;
                default:
              }
            },
            onSearchPressed: () {
              // Handle search action
              print('Search button pressed');
            },
          ),
        ),
      ),
    );
  }
}
