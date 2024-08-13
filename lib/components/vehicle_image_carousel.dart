import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class VehicleImageCarousel extends StatefulWidget {
  final Map<String, dynamic> vehicleData;

  VehicleImageCarousel({required this.vehicleData});

  @override
  _VehicleImageCarouselState createState() => _VehicleImageCarouselState();
}

class _VehicleImageCarouselState extends State<VehicleImageCarousel> {
  int _currentIndex = 0;
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    _extractImageUrls();
  }

  void _extractImageUrls() {
    _imageUrls = [];
    
    // Add main image
    if (widget.vehicleData['main_image'] != null && widget.vehicleData['main_image']['url'] != null) {
      _imageUrls.add(widget.vehicleData['main_image']['url']);
    }
    
    // Add category image
    if (widget.vehicleData['category'] != null && widget.vehicleData['category']['image_url'] != null) {
      _imageUrls.add(widget.vehicleData['category']['image_url']);
    }
    
    // Add any other images from collections or other sources
    if (widget.vehicleData['collections'] != null) {
      for (var collection in widget.vehicleData['collections']) {
        if (collection['image_url'] != null) {
          _imageUrls.add(collection['image_url']);
        }
      }
    }
    
    // If no images found, add a placeholder
    if (_imageUrls.isEmpty) {
      _imageUrls.add('https://via.placeholder.com/400x200');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: _imageUrls.map((imageUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Image.network(
                  'https://moveazy.axcertro.dev$imageUrl',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[300],
                      child: Icon(Icons.error),
                    );
                  },
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _imageUrls.asMap().entries.map((entry) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == entry.key
                    ? Colors.blue
                    : Colors.grey.withOpacity(0.5),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}