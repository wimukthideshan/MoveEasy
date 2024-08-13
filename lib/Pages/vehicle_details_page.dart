import 'package:flutter/material.dart';
import 'package:moveeasy/Model/vehicle_model.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';
import 'package:moveeasy/components/vehicle_image_carousel.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VehicleDetailsPage extends StatefulWidget {
  final int vehicleIndex;
  final bool isUserVehicle;
  final Vehicle? vehicle;

  // VehicleDetailsPage({required this.vehicleIndex});
  VehicleDetailsPage(
      {required this.vehicleIndex, this.isUserVehicle = false, this.vehicle});

  @override
  _VehicleDetailsPageState createState() => _VehicleDetailsPageState();
}

class _VehicleDetailsPageState extends State<VehicleDetailsPage> {
  bool _showFullDescription = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<VehicleProvider>(
      builder: (context, vehicleProvider, child) {
        // Use the passed vehicle if available, otherwise fetch from the provider
        // final vehicle = widget.vehicle ??
        //     (widget.isUserVehicle
        //         ? vehicleProvider.userVehicles[widget.vehicleIndex]
        //         : vehicleProvider.vehicles[widget.vehicleIndex]
        //         // : vehicleProvider.favoriteVehicles[widget.vehicleIndex]
        //         );
        Vehicle vehicle;
        if (widget.vehicle != null) {
          vehicle = widget.vehicle!;
        } else if (widget.isUserVehicle) {
          vehicle = vehicleProvider.userVehicles[widget.vehicleIndex];
        } else {
          vehicle = vehicleProvider.vehicles[widget.vehicleIndex];
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Image.asset('assets/logo.png', height: 50),
            backgroundColor: Colors.amber[800],
            actions: [
              IconButton(
  icon: Icon(
    vehicle.isFavorite ? Icons.favorite : Icons.favorite_border,
  ),
  color: vehicle.isFavorite ? const Color.fromARGB(255, 0, 0, 0) : null,
  onPressed: () async {
    try {
      Vehicle updatedVehicle = await vehicleProvider.toggleFavorite(vehicle);
      setState(() {
        vehicle = updatedVehicle;
      });
      // Refresh the favorites page
      vehicleProvider.loadFavoriteVehicles();

      // If the vehicle was removed from favorites, go back to the favorites page
      if (!updatedVehicle.isFavorite && widget.vehicle != null) {
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update favorite status')),
      );
    }
  },
),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VehicleImageCarousel(vehicleData: vehicle.toJson()),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vehicle.name,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Posted ${vehicle.createdAtHuman}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        '${vehicle.area}, ${vehicle.city}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Rs ${vehicle.price.toStringAsFixed(2)} / ${vehicle.payType}',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      SizedBox(height: 16),
                      _buildInfoRow('Vehicle Owner', vehicle.user.name),
                      _buildInfoRow(
                          'Email', vehicle.user.email ?? 'Not provided'),
                      _buildInfoRow(
                          'Phone', vehicle.user.mobile ?? 'Not provided'),
                      SizedBox(height: 16),
                      Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _showFullDescription
                            ? vehicle.description
                            : _truncateDescription(vehicle.description),
                        maxLines: _showFullDescription ? null : 3,
                        overflow: _showFullDescription
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      if (vehicle.description.length > 100)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _showFullDescription = !_showFullDescription;
                            });
                          },
                          child: Text(
                            _showFullDescription ? 'Show less' : 'Show more >',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomButtons(vehicle.user.mobile),
        );
      },
    );
  }

  String _getMainImageUrl(dynamic mainImage) {
    if (mainImage is Map && mainImage['url'] != null) {
      return 'https://moveazy.axcertro.dev${mainImage['url']}';
    } else if (mainImage is String) {
      return 'https://moveazy.axcertro.dev$mainImage';
    }
    return 'https://via.placeholder.com/400x200';
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }

  String _truncateDescription(String text) {
    if (text.length <= 100) {
      return text;
    }
    return text.substring(0, 100) + '...';
  }

  Widget _buildBottomButtons(String? phoneNumber) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              child: Text('WhatsApp'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                _launchWhatsApp(phoneNumber);
              },
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              child: Text('Call Now'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                _launchPhoneCall(phoneNumber);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _launchWhatsApp(String? phoneNumber) async {
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      String cleanedNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
      String whatsappUrl = "https://wa.me/$cleanedNumber";
      if (await canLaunch(whatsappUrl)) {
        await launch(whatsappUrl);
      } else {
        print('Could not launch WhatsApp');
      }
    } else {
      print('Phone number not available for WhatsApp');
    }
  }

  void _launchPhoneCall(String? phoneNumber) async {
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      await launchUrl(launchUri);
    } else {
      print('Phone number not available for calling');
    }
  }
}
