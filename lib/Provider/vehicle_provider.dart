import 'package:flutter/material.dart';
import 'package:moveeasy/Model/vehicle_model.dart';


class VehicleProvider with ChangeNotifier {
  List<Vehicle> _vehicles = [];

  List<Vehicle> get vehicles => _vehicles;

  void addVehicle(Vehicle vehicle) {
    _vehicles.add(vehicle);
    notifyListeners();
  }

  void clearVehicles() {
    _vehicles.clear();
    notifyListeners();
  }
}
