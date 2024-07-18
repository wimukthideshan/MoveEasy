import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';
import 'package:moveeasy/Model/vehicle_model.dart';
import 'package:moveeasy/Pages/vehicle_details_page.dart';

class VehicleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<VehicleProvider>(
      builder: (context, vehicleProvider, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: vehicleProvider.vehicles.length,
          itemBuilder: (context, index) {
            final vehicle = vehicleProvider.vehicles[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VehicleDetailsPage(vehicleIndex: index),
                  ),
                );
              },
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Image.asset(vehicle.imageUrl,
                        width: 120, height: 120, fit: BoxFit.cover),
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
              ),
            );
          },
        );
      },
    );
  }
}
