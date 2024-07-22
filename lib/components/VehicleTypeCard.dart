// import 'package:flutter/material.dart';
// import 'package:moveeasy/Provider/vehicle_provider.dart';
// import 'package:moveeasy/Pages/vehicle_list_page.dart';
// import 'package:provider/provider.dart';

// class VehicleTypeCard extends StatelessWidget {
//   final String type;

//   VehicleTypeCard({required this.type});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         final vehicles = Provider.of<VehicleProvider>(context, listen: false).getVehiclesByType(type);
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => VehicleListPage(vehicles: vehicles, title: '$type Vehicles'),
//           ),
//         );
//       },
//       child: Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               _getIconForType(type),
//               size: 40,
//               color: Theme.of(context).primaryColor,
//             ),
//             SizedBox(height: 8),
//             Text(
//               type,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   IconData _getIconForType(String type) {
//     switch (type.toLowerCase()) {
//       case 'suv':
//         return Icons.directions_car;
//       case 'car':
//         return Icons.car_rental;
//       case 'van':
//         return Icons.airport_shuttle;
//       case 'truck':
//         return Icons.local_shipping;
//       case 'motorcycle':
//         return Icons.motorcycle;
//       case 'bus':
//         return Icons.directions_bus;
//       default:
//         return Icons.directions_car;
//     }
//   }
// }