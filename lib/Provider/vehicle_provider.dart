import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moveeasy/Model/vehicle_model.dart';
import 'package:moveeasy/Service/api_service.dart';

class VehicleProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Vehicle> _vehicles = [];
  List<Vehicle> _filteredVehicles = [];
  List<Vehicle> _favoriteVehicles = [];
  Map<String, dynamic> _filterParams = {};
  String _selectedLocation = '';
  String _selectedCategory = '';
  List<Vehicle> _paidVehicles = [];
  int _currentPage = 1;
  int _totalPages = 1;
  int _perPage = 100;
  List<Vehicle> _userVehicles = [];
  bool _isLoading = false;

  List<Vehicle> get vehicles => _vehicles;
  List<Vehicle> get filteredVehicles => _filteredVehicles;
  List<Vehicle> get favoriteVehicles => _favoriteVehicles;
  List<Vehicle> get paidVehicles => _paidVehicles;
  Map<String, dynamic> get filterParams => _filterParams;
  String get selectedLocation => _selectedLocation;
  String get selectedCategory => _selectedCategory;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  List<Vehicle> get userVehicles => _userVehicles;
  bool get isLoading => _isLoading;

  void addVehicle(Vehicle vehicle) {
    _vehicles.add(vehicle);
    notifyListeners();
  }

  void clearVehicles() {
    _vehicles.clear();
    notifyListeners();
  }

  void sortVehiclesByPrice({bool ascending = true}) {
    _filteredVehicles.sort((a, b) =>
        ascending ? a.price.compareTo(b.price) : b.price.compareTo(a.price));
    notifyListeners();
  }

  void filterVehiclesByCategory(String category) {
    if (category == 'All') {
      _filteredVehicles = List.from(_vehicles);
    } else {
      _filteredVehicles =
          _vehicles.where((v) => v.category?.name == category).toList();
    }
    notifyListeners();
  }

  void _applyFilters() {
    _filteredVehicles = List.from(_vehicles);
    notifyListeners();
  }

  bool isFavorite(Vehicle vehicle) => vehicle.isFavorite;

  List<Vehicle> searchVehicles(String query) {
    _filteredVehicles = _vehicles
        .where((vehicle) =>
            vehicle.name.toLowerCase().contains(query.toLowerCase()) ||
            vehicle.description.toLowerCase().contains(query.toLowerCase()) ||
            (vehicle.category?.name.toLowerCase() ?? '')
                .contains(query.toLowerCase()))
        .toList();
    notifyListeners();
    return _filteredVehicles;
  }

  List<Vehicle> getVehiclesByCategory(String category) {
    _filteredVehicles = _vehicles
        .where((vehicle) =>
            vehicle.category?.name.toLowerCase() == category.toLowerCase())
        .toList();
    notifyListeners();
    return _filteredVehicles;
  }

  Vehicle? getVehicleById(int id) {
    try {
      return _vehicles.firstWhere((vehicle) => vehicle.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> fetchFilterParams() async {
    try {
      _filterParams = await _apiService.getFilterParams();
      notifyListeners();
    } catch (e) {
      print('Error fetching filter params: $e');
    }
  }

  void setFilterParams(Map<String, dynamic> params) {
    _filterParams = params;
    notifyListeners();
  }

  void setSelectedLocation(String location) {
    _selectedLocation = location;
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> createNewVehicle(Map<String, dynamic> vehicleData, List<File> images) async {
    print("DEBUG: VehicleProvider.createNewVehicle called");
    print("DEBUG: Vehicle data: $vehicleData");
    print("DEBUG: Number of images: ${images.length}");
    
    try {
      await _apiService.createVehicle(vehicleData, images);
      print("DEBUG: Vehicle created successfully in VehicleProvider");
      notifyListeners();
    } catch (e) {
      print('DEBUG: Error in VehicleProvider.createNewVehicle: $e');
      rethrow;
    }
  }

  void setPaidVehicles(List<Vehicle> vehicles) {
    _paidVehicles = vehicles;
    notifyListeners();
  }

  void setVehicles(List<Vehicle> newVehicles) {
    _vehicles = newVehicles;
    print('Number of vehicles set: ${_vehicles.length}');
    notifyListeners();
  }

  void setCurrentPage(int page) {
    _currentPage = page;
    loadFilteredVehicles();
  }

  Future<void> loadFilteredVehicles() async {
    print("loadFilteredVehicles started");
    try {
      final result = await _apiService.fetchFilteredVehicles(_perPage, _currentPage);
      
      List<Vehicle> allVehicles = [];

      if (result['services'] is Map && result['services']['secondLevel'] is List) {
        allVehicles.addAll((result['services']['secondLevel'] as List)
            .map((item) => Vehicle.fromJson(item)));
      }

      if (result['services'] is Map && result['services']['all'] is Map && result['services']['all']['data'] is List) {
        allVehicles.addAll((result['services']['all']['data'] as List)
            .map((item) => Vehicle.fromJson(item)));
        _totalPages = result['services']['all']['last_page'] ?? 1;
        _currentPage = result['services']['all']['current_page'] ?? 1;
      }

      _vehicles = allVehicles.toSet().toList();
      
      print("Filtered vehicles parsed: ${_vehicles.length}");
      notifyListeners();
    } catch (e) {
      print("Error in loadFilteredVehicles: $e");
      _vehicles = [];
      print('Number of filtered vehicles loaded: ${_vehicles.length}');
      notifyListeners();
    }
  }

  Future<void> fetchPaidVehicles() async {
    try {
      _paidVehicles = await _apiService.fetchPaidVehicles();
      notifyListeners();
    } catch (e) {
      print('Error fetching paid vehicles: $e');
    }
  }

  Future<void> fetchUserVehicles() async {
    try {
      final result = await _apiService.fetchUserVehicles();
      _userVehicles = (result['services'] as List)
          .map((item) => Vehicle.fromJson(item))
          .toList();
      notifyListeners();
    } catch (e) {
      print("Error fetching user vehicles: $e");
      _userVehicles = [];
      notifyListeners();
    }
  }

  Future<Vehicle> toggleFavorite(Vehicle vehicle) async {
  try {
    Vehicle updatedVehicle;
    if (vehicle.isFavorite) {
      await _apiService.removeFromFavorites(vehicle.favoriteId!);
      updatedVehicle = vehicle.copyWith(isFavorite: false, favoriteId: null);
    } else {
      await _apiService.addToFavorites(vehicle.id);
      // Since we don't have the new favoriteId, we'll just toggle isFavorite
      updatedVehicle = vehicle.copyWith(isFavorite: true);
    }
    
    // Update the vehicle in the _vehicles list
    final index = _vehicles.indexWhere((v) => v.id == vehicle.id);
    if (index != -1) {
      _vehicles[index] = updatedVehicle;
    }

    // Update the _favoriteVehicles list
    if (!updatedVehicle.isFavorite) {
      _favoriteVehicles.removeWhere((v) => v.id == vehicle.id);
    } else if (!_favoriteVehicles.any((v) => v.id == vehicle.id)) {
      _favoriteVehicles.add(updatedVehicle);
    }

    notifyListeners();

    // Refresh the favorite vehicles list
    await loadFavoriteVehicles();

    return updatedVehicle;
  } catch (e) {
    print('Error toggling favorite: $e');
    rethrow;
  }
}

  Future<void> loadFavoriteVehicles() async {
    _isLoading = true;
    notifyListeners();

    try {
      _favoriteVehicles = await _apiService.getFavoriteVehicles();
    } catch (e) {
      print('Error loading favorite vehicles: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}