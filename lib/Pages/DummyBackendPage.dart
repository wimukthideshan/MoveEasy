import 'package:flutter/material.dart';
import 'package:moveeasy/Model/vehicle_model.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';
import 'package:provider/provider.dart';

class DummyBackendPage extends StatelessWidget {
  final List<Vehicle> dummyVehicles = [
    Vehicle(
      title: 'Rent The Honda Fit Gp5',
      description: 'And Feel The Luxury With Low Price. Drive Anywhere.',
      pricePerKm: 230,
      imageUrl: 'assets/honda_fit.jpg',
      dateAdded: DateTime(2024, 3, 29, 11, 0),
    ),
    Vehicle(
      title: 'Brand New Land Rover',
      description: 'Experience luxury and power with our Land Rover.',
      pricePerKm: 340,
      imageUrl: 'assets/land_rover.jpg',
      dateAdded: DateTime(2024, 3, 29, 11, 0),
    ),
    // Add more dummy vehicles here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dummy Backend'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Add Dummy Vehicles'),
          onPressed: () {
            final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);
            for (var vehicle in dummyVehicles) {
              vehicleProvider.addVehicle(vehicle);
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Dummy vehicles added successfully!')),
            );
          },
        ),
      ),
    );
  }
}