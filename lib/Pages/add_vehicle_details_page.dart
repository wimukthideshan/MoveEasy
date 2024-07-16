import 'package:flutter/material.dart';
import 'package:moveeasy/Service/image_picker_service.dart';
import 'package:moveeasy/components/app_bar.dart';
import 'package:moveeasy/Model/vehicle_model.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class AddVehicleDetailsPage extends StatefulWidget {
  @override
  _AddVehicleDetailsPageState createState() => _AddVehicleDetailsPageState();
}

class _AddVehicleDetailsPageState extends State<AddVehicleDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePickerService _imagePickerService = ImagePickerService();
  List<File> _vehicleImages = [];
  String _priceUnit = 'Per Km';

  Future<void> _pickImages() async {
    final pickedImage = await _imagePickerService.pickImageFromGallery();
    if (pickedImage != null) {
      setState(() {
        _vehicleImages.add(pickedImage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Add New Vehicles'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please provide valid information to get approved.',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 16),
                Text(
                  'Vehicle Banner Image',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Please upload a image of your vehicle.\n1. Don't add any word inside the image.\n2. Image should clearly show the vehicle.\n3. You can maximum upload 3 vehicle images.",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: _pickImages,
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: _vehicleImages.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cloud_upload, size: 40, color: Colors.grey),
                              Text('Choose Image/s', style: TextStyle(color: Colors.grey)),
                            ],
                          )
                        : Image.file(_vehicleImages[0], fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 16),
                _buildTextField('Add Your Title', 'You may add eye catchy and SEO friendly title to your vehicle.'),
                _buildTextField('Describe about your best service', 'Describe about your vehicle conditions and also about your service, why some one need to rent your vehicle.'),
                _buildDropdown('Select the Category', 'Select your correct vehicle category', ['Van', 'Car', 'SUV']),
                _buildDropdown('Select the Available District', 'Select the vehicle available district here. Here you need to select he district that a visitor can get your vehicle', ['Colombo', 'Gampaha', 'Kandy']),
                _buildDropdown('Select the Available City', 'Select the vehicle available city here. Here you need to select he city that a visitor can get your vehicle', ['Nugegoda', 'Kotte', 'Battaramulla']),
                _buildPriceField(),
                SizedBox(height: 24),
                Row(
                    children: [
                    Expanded(
                      child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Save As Draft', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                      onPressed: _submitForApproval,
                      child: Text('Submit For Approval', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 121, 11, 3)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(hint, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!)),
          ),
          maxLength: 120,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDropdown(String label, String hint, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(hint, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!)),
          ),
          items: items.map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          onChanged: (_) {},
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPriceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Enter your best price', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text('Enter your best price here. cheap prices does not get more attractions.', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!)),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButton<String>(
                value: _priceUnit,
                items: ['Per Km', 'Per Mile'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _priceUnit = newValue!;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _submitForApproval() {
    if (_formKey.currentState?.validate() ?? false) {
      // Get the form data
      String title = ''; // Get the title from the form
      String description = ''; // Get the description from the form
      double pricePerKm = 0; // Get the price from the form

      // Create a new Vehicle object
      Vehicle newVehicle = Vehicle(
        title: title,
        description: description,
        pricePerKm: pricePerKm,
        imageUrl: _vehicleImages[0].path,
        dateAdded: DateTime.now(),
      );

      // Add the new vehicle to the VehicleProvider
      Provider.of<VehicleProvider>(context, listen: false).addVehicle(newVehicle);

      // Navigate back or show a success message
      Navigator.pop(context);
    }
  }
}