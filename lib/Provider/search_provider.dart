// search_provider.dart
import 'package:flutter/material.dart';
import 'package:moveeasy/Model/vehicle_model.dart';

class SearchProvider with ChangeNotifier {
  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  List<Vehicle> _searchResults = [];
  List<Vehicle> get searchResults => _searchResults;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  } 

  void setSearchResults(List<Vehicle> results) {
    _searchResults = results;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _searchResults.clear();
    notifyListeners();
  }
}