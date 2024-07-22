import 'package:flutter/material.dart';
import 'package:moveeasy/Model/vehicle_model.dart';
import 'package:moveeasy/components/search_results_list.dart';
import 'package:moveeasy/components/app_bar.dart';
import 'package:moveeasy/components/vehicle_list.dart';

class VehicleListPage extends StatelessWidget {
  final List<Vehicle> vehicles;
  final String title;

  VehicleListPage({required this.vehicles, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: SearchResultsList(vehicles: vehicles),
    );
  }
}