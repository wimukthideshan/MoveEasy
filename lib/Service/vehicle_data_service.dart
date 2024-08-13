// vehicle_data_service.dart
import 'package:flutter/material.dart';
import 'package:moveeasy/Model/vehicle_model.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';
import 'package:moveeasy/Service/api_service.dart';
import 'package:provider/provider.dart';

class VehicleDataService with ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Future<void> fetchVehicles(BuildContext context) async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     print("Calling API service to fetch vehicles");
  //     final vehicles = await _apiService.fetchVehicles();
  //     print('Fetched ${vehicles.length} vehicles from API'); // Add this line
  //     final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);
      
  //     vehicleProvider.clearVehicles();
  //     for (var vehicle in vehicles) {
  //       vehicleProvider.addVehicle(vehicle);
  //     }
  //     print("Added ${vehicles.length} vehicles to VehicleProvider");
  //   } catch (e) {
  //     print('Error fetching vehicles: $e');
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //     print("fetchVehicles completed in VehicleDataService");
  //   }
  // }

  Future<void> fetchPaidVehicles(BuildContext context) async {
    print("fetchPaidVehicles started");
  try {
    final paidVehicles = await _apiService.fetchPaidVehicles();
    print("Paid vehicles fetched: ${paidVehicles.length}");
    final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);
    vehicleProvider.setPaidVehicles(paidVehicles);
  } catch (e) {
    print("Error in fetchPaidVehicles: $e");
  }
}
}