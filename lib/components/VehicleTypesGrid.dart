import 'package:flutter/material.dart';
import 'package:moveeasy/Pages/vehicle_list_page.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';
import 'package:provider/provider.dart';

class VehicleTypeCard extends StatelessWidget {
  final String type;

  VehicleTypeCard({required this.type});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final vehicles = Provider.of<VehicleProvider>(context, listen: false).getVehiclesByType(type);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VehicleListPage(vehicles: vehicles, title: '$type Vehicles'),
          ),
        );
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_car),
            Text(type),
          ],
        ),
      ),
    );
  }
}