import 'package:flutter/material.dart';
import 'package:moveeasy/Model/vehicle_model.dart';

class VehicleProvider with ChangeNotifier {
  List<Vehicle> _vehicles = [];
  List<Vehicle> _filteredVehicles = [];

  List<Vehicle> get vehicles => _vehicles;
  List<Vehicle> get filteredVehicles => _filteredVehicles;
  void addVehicle(Vehicle vehicle) {
    _vehicles.add(vehicle);
    notifyListeners();
    _applyFilters();
  }

  void clearVehicles() {
    _vehicles.clear();
    _filteredVehicles.clear();
    notifyListeners();
  }

void sortVehiclesByPrice({bool ascending = true}) {
    _filteredVehicles.sort((a, b) => ascending
        ? a.pricePerKm.compareTo(b.pricePerKm)
        : b.pricePerKm.compareTo(a.pricePerKm));
    notifyListeners();
  }

void filterVehiclesByType(String type) {
    if (type == 'All') {
      _filteredVehicles = List.from(_vehicles);
    } else {
      _filteredVehicles = _vehicles.where((v) => v.type == type).toList();
    }
    notifyListeners();
  }

void _applyFilters() {
    // Apply any active filters here
    _filteredVehicles = List.from(_vehicles);
    notifyListeners();
  }


}
