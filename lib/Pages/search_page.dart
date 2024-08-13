import 'package:flutter/material.dart';
import 'package:moveeasy/Provider/search_provider.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';
import 'package:moveeasy/components/location_picker.dart';
import 'package:moveeasy/components/search_results_list.dart';
import 'package:provider/provider.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VehicleProvider>(context, listen: false).fetchFilterParams();
    });
  }

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
              _buildSearchBar(searchProvider),
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

  Widget _buildSearchBar(SearchProvider searchProvider) {
    bool showBackButton = searchProvider.searchResults.isNotEmpty || searchProvider.searchQuery.isNotEmpty;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.amber[800],
      child: Row(
        children: [
          if (showBackButton)
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => _handleBackPress(),
            ),
          Expanded(
            child: Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'What are you looking for?',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                      style: TextStyle(fontSize: 16),
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
    return Consumer<VehicleProvider>(
      builder: (context, vehicleProvider, _) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Icon(Icons.location_on, color: Colors.green),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  vehicleProvider.selectedLocation.isEmpty
                      ? 'Select Location'
                      : vehicleProvider.selectedLocation,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextButton(
                child: Text('Change location', style: TextStyle(color: Colors.blue)),
                onPressed: () => _showLocationPicker(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLocationPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => LocationPickerWidget(),
    );
  }

  Widget _buildVehicleTypesGrid() {
    return Consumer<VehicleProvider>(
      builder: (context, vehicleProvider, _) {
        final categories = vehicleProvider.filterParams['category'] as List<dynamic>? ?? [];
        
        return GridView.builder(
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildVehicleTypeItem(
              type: category['name'] as String,
              icon: _getCategoryIcon(category['name']),
              color: _getCategoryColor(index),
            );
          },
        );
      },
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'car':
        return Icons.directions_car;
      case 'suv':
        return Icons.directions_car;
      case 'van':
        return Icons.airport_shuttle;
      case 'truck':
        return Icons.local_shipping;
      case 'motorcycle':
        return Icons.motorcycle;
      default:
        return Icons.category;
    }
  }

  Color _getCategoryColor(int index) {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
    ];
    return colors[index % colors.length];
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
          Text(type, style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
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
    setState(() {}); // Trigger a rebuild to update the back button visibility
  }

  void _filterVehiclesByType(String type) {
    final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    final results = vehicleProvider.getVehiclesByCategory(type);
    searchProvider.setSearchQuery(type);
    searchProvider.setSearchResults(results);
    setState(() {}); // Trigger a rebuild to update the back button visibility
  }

  Future<bool> _onWillPop() async {
    return _handleBackPress();
  }

  bool _handleBackPress() {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    if (searchProvider.searchResults.isNotEmpty || searchProvider.searchQuery.isNotEmpty) {
      searchProvider.clearSearch();
      _searchController.clear();
      setState(() {}); // Trigger a rebuild to update the back button visibility
      return false;
    }
    return true;
  }
}