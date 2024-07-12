import 'package:flutter/material.dart';
import 'package:moveeasy/State/auth_provider.dart';
import 'package:moveeasy/State/navigation_state_provider.dart';
import 'package:moveeasy/components/app_bar.dart';
import 'package:moveeasy/navigation/navigation_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  // void _onSearchPressed(BuildContext context) {
  //   // Handle search button press
  //   print("Search button pressed");
  //   // You can navigate to a search page or handle the search action here
  // }

  @override
  Widget build(BuildContext context) {
    final navigationStateProvider =
        Provider.of<NavigationStateProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      body: Center(
        child: Text('Home Page Content'),
      ),
    );
  }
}
