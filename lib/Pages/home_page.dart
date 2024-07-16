

import 'package:flutter/material.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';
import 'package:moveeasy/Service/vehicle_data_service.dart';
import 'package:moveeasy/components/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch vehicles when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VehicleDataService>(context, listen: false).fetchVehicles(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehicleProvider>(context);
    final dataService = Provider.of<VehicleDataService>(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      body: dataService.isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFeaturedVehicleCard(vehicleProvider),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('RENT A VEHICLE EASY',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Price Low To High',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  _buildVehicleList(vehicleProvider),
                ],
              ),
            ),
    );
  }

  Widget _buildFeaturedVehicleCard(VehicleProvider vehicleProvider) {
    final featuredVehicle = vehicleProvider.vehicles.isNotEmpty
        ? vehicleProvider.vehicles.first
        : null;

    if (featuredVehicle == null) {
      return SizedBox.shrink();
    }

    return Container(
      height: 200,
      child: Stack(
        children: [
          Image.asset(featuredVehicle.imageUrl, fit: BoxFit.cover, width: double.infinity),
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(featuredVehicle.title,
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Rs ${featuredVehicle.pricePerKm.toStringAsFixed(2)}/km',
                    style: TextStyle(color: Colors.amber, fontSize: 16)),
                Text(DateFormat('MMM dd, yyyy - hh:mm a').format(featuredVehicle.dateAdded),
                    style: TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleList(VehicleProvider vehicleProvider) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: vehicleProvider.vehicles.length,
      itemBuilder: (context, index) {
        final vehicle = vehicleProvider.vehicles[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Image.asset(vehicle.imageUrl, width: 120, height: 120, fit: BoxFit.cover),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(vehicle.title, style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(vehicle.description),
                      SizedBox(height: 8),
                      Text('RS ${vehicle.pricePerKm.toStringAsFixed(2)}/Km', 
                           style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                      Text(DateFormat('MMM dd, yyyy - hh:mm a').format(vehicle.dateAdded), 
                           style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}