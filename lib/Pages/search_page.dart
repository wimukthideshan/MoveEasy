// search_page.dart
import 'package:flutter/material.dart';
import 'package:moveeasy/Model/vehicle_model.dart';
import 'package:moveeasy/components/search_results_list.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';
import 'package:moveeasy/Provider/search_provider.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String currentLocation = 'Kurunegala'; // This should be dynamic in a real app
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _buildSearchBar(),
              _buildLocationBar(),
              Expanded(
                child: searchProvider.searchResults.isEmpty
                    ? _buildVehicleTypesGrid()
                    : SearchResultsList(vehicles: searchProvider.searchResults),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.amber[800],
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => _handleBackPress(),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'What are you looking for?',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (query) => _performSearch(query, searchProvider),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _performSearch(_searchController.text, searchProvider),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(Icons.location_on, color: Colors.green),
          SizedBox(width: 8),
          Text(currentLocation),
          Spacer(),
          TextButton(
            child: Text('Change location', style: TextStyle(color: Colors.blue)),
            onPressed: () {
              // Implement location change functionality
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleTypesGrid() {
    final vehicleTypes = [
      {'type': 'Car', 'icon': Icons.directions_car, 'color': Colors.blue},
      {'type': 'SUV', 'icon': Icons.directions_car, 'color': Colors.red},
      {'type': 'Hatchback', 'icon': Icons.directions_car, 'color': Colors.green},
      {'type': 'Van', 'icon': Icons.airport_shuttle, 'color': Colors.orange},
      {'type': 'Truck', 'icon': Icons.local_shipping, 'color': Colors.purple},
      {'type': 'Motorcycle', 'icon': Icons.motorcycle, 'color': Colors.teal},
    ];

    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: vehicleTypes.length,
      itemBuilder: (context, index) {
        final vehicleType = vehicleTypes[index];
        return _buildVehicleTypeItem(
          type: vehicleType['type'] as String,
          icon: vehicleType['icon'] as IconData,
          color: vehicleType['color'] as Color,
        );
      },
    );
  }

  Widget _buildVehicleTypeItem({required String type, required IconData icon, required Color color}) {
    return GestureDetector(
      onTap: () => _filterVehiclesByType(type),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          SizedBox(height: 8),
          Text(type, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  void _performSearch(String query, SearchProvider searchProvider) {
    if (query.isNotEmpty) {
      final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);
      final results = vehicleProvider.searchVehicles(query);
      searchProvider.setSearchQuery(query);
      searchProvider.setSearchResults(results);
    }
  }

  void _filterVehiclesByType(String type) {
    final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    final results = vehicleProvider.getVehiclesByType(type);
    searchProvider.setSearchResults(results);
  }

  Future<bool> _onWillPop() async {
    return _handleBackPress();
  }

  bool _handleBackPress() {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    if (searchProvider.searchResults.isNotEmpty) {
      searchProvider.clearSearch();
      _searchController.clear();
      return false;
    }
    return true;
  }
}