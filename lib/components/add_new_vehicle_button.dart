import 'package:flutter/material.dart';
import 'package:moveeasy/pages/add_vehicle_details_page.dart';

class AddNewVehicleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddVehicleDetailsPage()),
        );
      },
      child: Text('Add a New Vehicle'),
    );
  }
}
