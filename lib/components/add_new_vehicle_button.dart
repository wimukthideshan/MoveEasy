import 'package:flutter/material.dart';
import 'package:moveeasy/Pages/add_vehicle_details_page.dart';
import 'package:moveeasy/utils/bottom_slide_page_route.dart';

class AddNewVehicleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => AddVehicleDetailsPage(),
  );
},
      child: Text(
        'Add a New Vehicle',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, // Button color
        foregroundColor: Colors.white, // Text color
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}