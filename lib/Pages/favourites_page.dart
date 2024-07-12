// home_page.dart
import 'package:flutter/material.dart';
import 'package:moveeasy/components/app_bar.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Favorite Page',
      ),
      body: Center(
        child: Text('Favorite Page Content'),
      ),
    );
  }
}
