import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moveeasy/Model/vehicle_model.dart';
import 'package:moveeasy/Pages/vehicle_details_page.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';
import 'package:provider/provider.dart';

class VehicleList extends StatelessWidget {
  final List<Vehicle>? vehicles;

  VehicleList({this.vehicles});

  @override
  Widget build(BuildContext context) {
    return Consumer<VehicleProvider>(
      builder: (context, vehicleProvider, child) {
        final displayVehicles = vehicles ?? vehicleProvider.vehicles;
        
        
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: displayVehicles.length,
          itemBuilder: (context, index) {
            final vehicle = displayVehicles[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VehicleDetailsPage(vehicleIndex: vehicleProvider.vehicles.indexOf(vehicle)),
                  ),
                );
              },
              child: VehicleCard(vehicle: vehicle),
            );
          },
        );
      },
    );
  }
}

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;

  VehicleCard({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.asset(
              vehicle.imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(vehicle.title,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(vehicle.description),
                  SizedBox(height: 8),
                  Text('RS ${vehicle.pricePerKm.toStringAsFixed(2)}/Km',
                      style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold)),
                  Text(
                      DateFormat('MMM dd, yyyy - hh:mm a')
                          .format(vehicle.dateAdded),
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
