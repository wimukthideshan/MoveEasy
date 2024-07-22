import 'package:flutter/material.dart';
import 'package:moveeasy/Model/vehicle_model.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';
import 'package:moveeasy/components/app_bar.dart';
import 'package:provider/provider.dart';

class VehicleDetailsPage extends StatelessWidget {
  final int vehicleIndex;

  VehicleDetailsPage({required this.vehicleIndex});

  @override
    Widget build(BuildContext context) {
    return Consumer<VehicleProvider>(
      builder: (context, vehicleProvider, child) {
        final vehicle = vehicleProvider.vehicles[vehicleIndex];
        final isFavorite = vehicleProvider.isFavorite(vehicle);

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Image.asset('assets/logo.png', height: 50),
            backgroundColor: Colors.amber[800],
            actions: [
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? const Color.fromARGB(255, 20, 15, 15) : null,
                ),
                onPressed: () {
                  vehicleProvider.toggleFavorite(vehicle);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageCarousel(vehicle),
                _buildVehicleDetails(vehicle),
                _buildContactInformation(),
                _buildVehicleOwner(),
                _buildUserRatings(),
                _buildOtherVehicles(vehicleProvider),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomButtons(),
        );
      },
    );
  }

  Widget _buildImageCarousel(Vehicle vehicle) {
    return Container(
      height: 250,
      child: PageView(
        children: [
          Image.asset(vehicle.imageUrl, fit: BoxFit.cover),
          // Add more images if available
        ],
      ),
    );
  }

  Widget _buildVehicleDetails(Vehicle vehicle) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(vehicle.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(vehicle.description),
          SizedBox(height: 8),
          Text('Price: LKR${vehicle.pricePerKm.toStringAsFixed(2)}/km', 
               style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildContactInformation() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact Information', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('WhatsApp: 076****544321'),
          Text('Phone: 076****544321, 077****544325'),
        ],
      ),
    );
  }

  Widget _buildVehicleOwner() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/owner_avatar.jpg'),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tilina', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Age: 28Y Gender: Male'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserRatings() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('User Ratings', style: TextStyle(fontWeight: FontWeight.bold)),
          // Add user ratings here
        ],
      ),
    );
  }

  Widget _buildOtherVehicles(VehicleProvider vehicleProvider) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Other Vehicles of the Owner', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          // Add a list of other vehicles here
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              child: Text('WhatsApp'),
              onPressed: () {
                // Implement WhatsApp functionality
              },
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              child: Text('Call Now'),
              onPressed: () {
                // Implement call functionality
              },
            ),
          ),
        ],
      ),
    );
  }
}