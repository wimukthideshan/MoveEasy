// home_page.dart
import 'package:flutter/material.dart';
import 'package:moveeasy/components/app_bar.dart';

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'profile'),
      body: Center(
        child: Text('my Profile Page Content'),
      ),
    );
  }
}
