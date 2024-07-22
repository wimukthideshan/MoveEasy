// custom_search_button.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moveeasy/Provider/navigation_state_provider.dart';

class CustomSearchButton extends StatelessWidget {
  final bool isSelected;

  CustomSearchButton({
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationStateProvider>(
      builder: (context, navigationProvider, child) {
        return FloatingActionButton(
          // onPressed: () => navigationProvider.navigateToSearch(),
          onPressed: null,
          backgroundColor: Colors.amber[800],
          child: Icon(Icons.search, color: Colors.black),
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          materialTapTargetSize: MaterialTapTargetSize.padded,
        );
      },
    );
  }
}