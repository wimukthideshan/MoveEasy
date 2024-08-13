import 'package:flutter/material.dart';
import 'package:moveeasy/Pages/search_page.dart';
import 'package:moveeasy/Pages/add_vehicle_page.dart';
import 'package:moveeasy/Pages/favourites_page.dart';
import 'package:moveeasy/Pages/home_page.dart';
import 'package:moveeasy/Pages/my_profile_page.dart';
import 'package:moveeasy/Provider/navigation_state_provider.dart';
import 'package:moveeasy/navigation/navigation_bar.dart';
import 'package:provider/provider.dart';

class MainNavigationPage extends StatelessWidget {
  final List<Widget> _pages = [
    HomePage(),
    AddVehiclePage(),
    SearchPage(),
    FavoritesPage(),
    MyProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationStateProvider>(
      builder: (context, navigationStateProvider, _) => Scaffold(
        body: IndexedStack(
          index: navigationStateProvider.selectedIndex,
          children: _pages,
        ),
        
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: navigationStateProvider.selectedIndex,
          onItemTapped: (index) {
            navigationStateProvider.setSelectedIndex(index);
          },
          onSearchPressed: () => navigationStateProvider.setSelectedIndex(2),
        ),
      ),
    );
  }
}
