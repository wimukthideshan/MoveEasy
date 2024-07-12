import 'package:flutter/material.dart';

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
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
      ),
      child: Stack(
        children: [
          BottomNavigationBar(
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
                icon: Container(), // Empty container for the placeholder
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
                onItemTapped(index); // Call onItemTapped for other indices
              } else {
                onSearchPressed(); // Call onSearchPressed for the search button index
              }
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: FloatingActionButton(
                  onPressed: onSearchPressed,
                  backgroundColor: Colors.amber[800],
                  child: Icon(Icons.search, color: Colors.black),
                  elevation: 2.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
