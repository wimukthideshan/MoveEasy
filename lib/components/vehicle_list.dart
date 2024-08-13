// vehicle_list.dart
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
        print("VehicleList build called. Vehicles count: ${vehicleProvider.vehicles.length}");
        final displayVehicles = vehicles ?? vehicleProvider.vehicles;

        if (vehicleProvider.vehicles.isEmpty) {
          return Center(child: Text("No vehicles available"));
        }
        
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
      height: 120, // Fixed height for the card
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
            child: Image.network(
              vehicle.mainImageUrl,
              width: 120,
              height: 140,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120,
                  height: 140,
                  color: Colors.grey[300],
                  child: Icon(Icons.error),
                );
              },
            )
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicle.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    vehicle.description,
                    style: TextStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Text(
                    '${vehicle.price.toStringAsFixed(2)} ${vehicle.payType}',
                    style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    DateFormat('MMM dd, yyyy - hh:mm a').format(DateTime.parse(vehicle.createdAt)),
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}