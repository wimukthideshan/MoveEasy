import 'package:flutter/material.dart';

class CustomSearchButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onPressed;

  CustomSearchButton({
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: isSelected ? Colors.amber[800] : Colors.yellow,
      child: Icon(Icons.search, color: Colors.black),
      elevation: 2.0,
    );
  }
}
