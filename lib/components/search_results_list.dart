// search_results_list.dart
import 'package:flutter/material.dart';
import 'package:moveeasy/Model/vehicle_model.dart';
import 'package:moveeasy/Pages/vehicle_details_page.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';
import 'package:moveeasy/components/vehicle_list.dart';
import 'package:provider/provider.dart';

class SearchResultsList extends StatelessWidget {
  final List<Vehicle> vehicles;

  SearchResultsList({required this.vehicles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: vehicles.length,
      itemBuilder: (context, index) {
        final vehicle = vehicles[index];
        return GestureDetector(
          onTap: () {
            final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);
            final vehicleIndex = vehicleProvider.vehicles.indexOf(vehicle);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VehicleDetailsPage(vehicleIndex: vehicleIndex),
              ),
            );
          },
          child: VehicleCard(vehicle: vehicle),
        );
      },
    );
  }
}