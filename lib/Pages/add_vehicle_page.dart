import 'package:flutter/material.dart';
import 'package:moveeasy/components/app_bar.dart';
import 'package:moveeasy/components/add_new_vehicle_button.dart';
import 'package:moveeasy/components/login_required.dart';
import 'package:moveeasy/components/vehicle_list.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';
import 'package:moveeasy/Provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:moveeasy/Pages/vehicle_details_page.dart';


class AddVehiclePage extends StatefulWidget {
  @override
  _AddVehiclePageState createState() => _AddVehiclePageState();
}

Future<void> _refreshVehicles(BuildContext context) async {
  await Provider.of<VehicleProvider>(context, listen: false).fetchUserVehicles();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).checkAuthStatus();
      Provider.of<VehicleProvider>(context, listen: false).fetchUserVehicles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Vehicles',
      ),
      body: authProvider.isAuthenticated
          ? RefreshIndicator(
              onRefresh: () => _refreshVehicles(context),
              child: Consumer<VehicleProvider>(
                builder: (context, vehicleProvider, child) {
                  // Existing content...
                  if (vehicleProvider.userVehicles.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.directions_car,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No vehicles added yet',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Add your first vehicle to start renting',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Stack(
                      children: [
                        ListView.builder(
                          itemCount: vehicleProvider.userVehicles.length,
                          itemBuilder: (context, index) {
                            final vehicle = vehicleProvider.userVehicles[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VehicleDetailsPage(vehicleIndex: index, isUserVehicle: true),
                                  ),
                                );
                              },
                              child: VehicleCard(vehicle: vehicle),
                            );
                          },
                        ),
                        Positioned(
                          right: 10,
                          bottom: 20,
                          child: AddNewVehicleButton(),
                        ),
                      ],
                    );
                  }
                },
              ),
            )
          : LoginRequiredWidget(),
    );
  }
}