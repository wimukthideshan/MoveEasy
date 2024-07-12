import 'package:flutter/material.dart';
import 'package:moveeasy/components/app_bar.dart';

class AddVehiclePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Add a vehicle'),
      body: Center(
        child: Text('This is the Add Vehicle Page'),
      ),
    );
  }
}
