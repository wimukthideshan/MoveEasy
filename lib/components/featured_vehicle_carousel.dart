import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';

class FeaturedVehicleCarousel extends StatefulWidget {
  @override
  _FeaturedVehicleCarouselState createState() => _FeaturedVehicleCarouselState();
}

class _FeaturedVehicleCarouselState extends State<FeaturedVehicleCarousel> {
  PageController _pageController = PageController();
  int _currentFeaturedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<VehicleProvider>(
      builder: (context, vehicleProvider, child) {
        return Container(
          height: 200,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: vehicleProvider.vehicles.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentFeaturedIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final vehicle = vehicleProvider.vehicles[index];
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(vehicle.imageUrl, fit: BoxFit.cover),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.8),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(vehicle.title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text('Rs ${vehicle.pricePerKm.toStringAsFixed(2)}/km',
                                  style: TextStyle(color: Colors.amber, fontSize: 16)),
                              Text(
                                  DateFormat('MMM dd, yyyy - hh:mm a')
                                      .format(vehicle.dateAdded),
                                  style: TextStyle(color: Colors.white, fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onPressed: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
