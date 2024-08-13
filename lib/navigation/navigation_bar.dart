// navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:moveeasy/Provider/navigation_state_provider.dart';
import 'package:moveeasy/components/custom_search_button.dart';
import 'package:provider/provider.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final VoidCallback onSearchPressed;

  CustomBottomNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
    required this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.car_rental),
                label: 'Add A Vehicle',
              ),
              BottomNavigationBarItem(
                icon: Container(), // Empty container for the search button placeholder
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'My Profile',
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: Colors.amber[800],
            unselectedItemColor: Colors.black,
            onTap: (index) {
              if (index != 2) {
                onItemTapped(index);
              }
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
          ),
        ),
                Positioned(
          top: -15, // Adjust this value as needed
          child: Consumer<NavigationStateProvider>(
            builder: (context, navigationProvider, child) {
              return GestureDetector(
                onTap: () => navigationProvider.navigateToSearch(),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 60,
                  height: 60,
                  color: Colors.transparent,
                  child: Center(
                    child: CustomSearchButton(isSelected: selectedIndex == 2),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}