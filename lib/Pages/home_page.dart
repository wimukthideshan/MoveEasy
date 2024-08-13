// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';
import 'package:moveeasy/Service/vehicle_data_service.dart';
import 'package:moveeasy/components/app_bar.dart';
import 'package:moveeasy/components/filter_bar.dart';
import 'package:moveeasy/components/vehicle_list.dart';
import 'package:moveeasy/components/featured_vehicle_carousel.dart';
import 'package:moveeasy/components/pagination.dart';
import 'package:moveeasy/components/loading_indicator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage> {
  bool _isLoading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);
    final dataService = Provider.of<VehicleDataService>(context, listen: false);
    
    await Future.wait([
      vehicleProvider.loadFilteredVehicles(),
      dataService.fetchPaidVehicles(context),
    ]);
    
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: _isLoading
          ? LoadingIndicator()
          : SingleChildScrollView(
              child: Column(
                children: [
                  FilterBar(),
                  FeaturedVehicleCarousel(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('RENT A VEHICLE EASY',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  VehicleList(),
                  Consumer<VehicleProvider>(
                    builder: (context, vehicleProvider, child) {
                      return Pagination(
                        currentPage: vehicleProvider.currentPage,
                        totalPages: vehicleProvider.totalPages,
                        onPageChanged: (page) {
                          vehicleProvider.setCurrentPage(page);
                          _loadData();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
      ),
    );
  }
}