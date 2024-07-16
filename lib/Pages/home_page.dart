import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';
import 'package:moveeasy/Service/vehicle_data_service.dart';
import 'package:moveeasy/components/app_bar.dart';
import 'package:moveeasy/components/filter_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentFeaturedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VehicleDataService>(context, listen: false).fetchVehicles(context);
      _startFeaturedCarousel();
    });
  }

  void _startFeaturedCarousel() {
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);
        setState(() {
          _currentFeaturedIndex = (_currentFeaturedIndex + 1) % vehicleProvider.vehicles.length;
        });
        _pageController.animateToPage(
          _currentFeaturedIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _startFeaturedCarousel();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehicleProvider>(context);
    final dataService = Provider.of<VehicleDataService>(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      body: dataService.isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFeaturedVehicleCarousel(vehicleProvider),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('RENT A VEHICLE EASY',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        VehicleFilterOptions(),
                      ],
                    ),
                  ),
                  _buildVehicleList(vehicleProvider),
                ],
              ),
            ),
    );
  }

Widget _buildFeaturedVehicleCarousel(VehicleProvider vehicleProvider) {
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
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Rs ${vehicle.pricePerKm.toStringAsFixed(2)}/km',
                            style: TextStyle(color: Colors.amber, fontSize: 16)),
                        Text(DateFormat('MMM dd, yyyy - hh:mm a').format(vehicle.dateAdded),
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
  }

  Widget _buildVehicleList(VehicleProvider vehicleProvider) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: vehicleProvider.vehicles.length,
      itemBuilder: (context, index) {
        final vehicle = vehicleProvider.vehicles[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Image.asset(vehicle.imageUrl, width: 120, height: 120, fit: BoxFit.cover),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(vehicle.title, style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(vehicle.description),
                      SizedBox(height: 8),
                      Text('RS ${vehicle.pricePerKm.toStringAsFixed(2)}/Km', 
                           style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                      Text(DateFormat('MMM dd, yyyy - hh:mm a').format(vehicle.dateAdded), 
                           style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}