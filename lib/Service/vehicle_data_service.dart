// lib/services/vehicle_data_service.dart

import 'package:flutter/material.dart';
import 'package:moveeasy/Model/vehicle_model.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';
import 'package:provider/provider.dart';

class VehicleDataService with ChangeNotifier {
  final List<Vehicle> _dummyVehicles = [
    Vehicle(
      title: 'Rent The Honda Fit Gp5',
      description: 'And Feel The Luxury With Low Price. Drive Anywhere.',
      pricePerKm: 230,
      imageUrl: 'assets/honda_fit.jpg',
      dateAdded: DateTime(2024, 3, 29, 11, 0),
      type: 'Car',
    ),
    Vehicle(
      title: 'Brand New Land Rover',
      description: 'Experience luxury and power with our Land Rover.',
      pricePerKm: 340,
      imageUrl: 'assets/land_rover.jpg',
      dateAdded: DateTime(2024, 3, 29, 11, 0),
      type: 'SUV',
    ),
    Vehicle(
      title: 'Brand New Land Rover',
      description: 'Experience luxury and power with our Land Rover.',
      pricePerKm: 340,
      imageUrl: 'assets/land_rover.jpg',
      dateAdded: DateTime(2024, 3, 29, 11, 0),
      type: 'SUV',
    ),
    Vehicle(
      title: 'Rent The Honda Fit Gp5',
      description: 'And Feel The Luxury With Low Price. Drive Anywhere.',
      pricePerKm: 230,
      imageUrl: 'assets/honda_fit.jpg',
      dateAdded: DateTime(2024, 3, 29, 11, 0),
      type: 'Car',
    ),
    Vehicle(
      title: 'Rent The Honda Fit Gp5',
      description: 'And Feel The Luxury With Low Price. Drive Anywhere.',
      pricePerKm: 230,
      imageUrl: 'assets/honda_fit.jpg',
      dateAdded: DateTime(2024, 3, 29, 11, 0),
      type: 'Car',
    ),

    // Add more dummy vehicles here
  ];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchVehicles(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);
    
    // Clear existing vehicles
    vehicleProvider.clearVehicles();

    // Add dummy vehicles
    for (var vehicle in _dummyVehicles) {
      vehicleProvider.addVehicle(vehicle);
    }

    _isLoading = false;
    notifyListeners();
  }
}