import 'package:flutter/material.dart';
import 'package:moveeasy/components/app_bar.dart';
import 'package:moveeasy/components/add_new_vehicle_button.dart';

class AddVehiclePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Vehicles',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Rent your vehicle quickly. Add it here for free.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                // _buildVehicleCard(),
                // _buildVehicleCard(),
                // vehicle cards will be added here
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AddNewVehicleButton(),
          ),
        ],
      ),

    );
  }




}