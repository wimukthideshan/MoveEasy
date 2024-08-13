import 'package:flutter/material.dart';
import 'package:moveeasy/components/app_bar.dart';
import 'package:moveeasy/components/loading_indicator.dart';
import 'package:moveeasy/components/login_required.dart';
import 'package:moveeasy/components/vehicle_list.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';
import 'package:moveeasy/Provider/auth_provider.dart';
import 'package:moveeasy/Pages/vehicle_details_page.dart';
import 'package:provider/provider.dart';


class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).checkAuthStatus();
      Provider.of<VehicleProvider>(context, listen: false).loadFavoriteVehicles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Favorite Vehicles',
      ),
      body: authProvider.isAuthenticated
          ? Consumer<VehicleProvider>(
              builder: (context, vehicleProvider, child) {
                if (vehicleProvider.isLoading) {
                  return Center(child: LoadingIndicator());
                } else if (vehicleProvider.favoriteVehicles.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No favorite vehicles yet',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Add vehicles to your favorites to see them here',
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
                  return RefreshIndicator(
                    onRefresh: () => vehicleProvider.loadFavoriteVehicles(),
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Your Favorite Vehicles',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: vehicleProvider.favoriteVehicles.length,
                            itemBuilder: (context, index) {
                              final vehicle = vehicleProvider.favoriteVehicles[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VehicleDetailsPage(
                                        vehicleIndex: index,
                                        vehicle: vehicle,
                                      ),
                                    ),
                                  );
                                },
                                child: VehicleCard(vehicle: vehicle),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            )
          : LoginRequiredWidget(),
    );
  }
}