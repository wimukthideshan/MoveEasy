import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';

class VehicleFilterOptions extends StatefulWidget {
  @override
  _VehicleFilterOptionsState createState() => _VehicleFilterOptionsState();
}

class _VehicleFilterOptionsState extends State<VehicleFilterOptions> {
  String _selectedVehicleType = 'All';
  bool _ascendingSort = true;

  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);

    return Row(
      children: [
        // DropdownButton<String>(
        //   value: _selectedVehicleType,
        //   items: ['All', 'Sedan', 'SUV', 'Hatchback'].map((String value) {
        //     return DropdownMenuItem<String>(
        //       value: value,
        //       child: Text(value),
        //     );
        //   }).toList(),
        //   onChanged: (newValue) {
        //     setState(() {
        //       _selectedVehicleType = newValue!;
        //       vehicleProvider.filterVehiclesByType(_selectedVehicleType);
        //     });
        //   },
        // ),
        SizedBox(width: 16),
        GestureDetector(
          onTap: () {
            setState(() {
              _ascendingSort = !_ascendingSort;
              vehicleProvider.sortVehiclesByPrice(ascending: _ascendingSort);
            });
          },
          child: Row(
            children: [
              Text(_ascendingSort ? 'Price Low to High' : 'Price High to Low'),
              Icon(_ascendingSort ? Icons.arrow_upward : Icons.arrow_downward),
            ],
          ),
        ),
      ],
    );
  }
}