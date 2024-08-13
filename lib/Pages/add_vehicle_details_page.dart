import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';
import 'package:moveeasy/Service/image_picker_service.dart';
import 'package:provider/provider.dart';

class AddVehicleDetailsPage extends StatefulWidget {
  @override
  _AddVehicleDetailsPageState createState() => _AddVehicleDetailsPageState();
}

class _AddVehicleDetailsPageState extends State<AddVehicleDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePickerService _imagePickerService = ImagePickerService();
  List<File> _vehicleImages = [];
  String _priceUnit = 'km';
  String _selectedCategory = '';
  String _selectedDistrict = '';
  String _selectedCity = '';
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VehicleProvider>(context, listen: false).fetchFilterParams();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
  if (_vehicleImages.length >= 3) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You can only upload a maximum of 3 images')),
    );
    return;
  }

  final pickedImage = await _imagePickerService.pickImageFromGallery();
  if (pickedImage != null) {
    setState(() {
      _vehicleImages.add(pickedImage);
    });
    print('Image added: ${pickedImage.path}');
  } else {
    print('No image selected');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('No image selected. Please try again.')),
    );
  }
}

@override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehicleProvider>(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.amber[800],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text(
                        'Add New Vehicle',
                        style: TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 48), // To balance the close button
                    ],
                  ),
                ),
                Divider(height: 1, color: Colors.grey[300]),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
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
                            _buildImagePicker(),
                            SizedBox(height: 16),
                            _buildTextField('Add Your Title', 'You may add eye catchy and SEO friendly title to your vehicle.', _nameController, maxLength: 120),
                            _buildTextField('Describe about your best service', 'Describe about your vehicle conditions and also about your service, why some one need to rent your vehicle.', _descriptionController, maxLength: 120),
                            _buildDropdown('Select the Category', 'Select your correct vehicle category', vehicleProvider.filterParams['category'] ?? []),
                            _buildDropdown('Select the Available District', 'Select the vehicle available district here.', vehicleProvider.filterParams['area'] ?? []),
                            _buildDropdown('Select the Available City', 'Select the vehicle available city here.', vehicleProvider.filterParams['area'] ?? []),
                            _buildPriceField(),
                            SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: _submitForApproval,
                              child: Text('Submit For Approval', style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 121, 11, 3),
                                minimumSize: Size(double.infinity, 50),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImagePicker() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Vehicle Banner Image', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      Text("Please upload images of your vehicle.\n1. Don't add any word inside the image.\n2. Image should clearly show the vehicle.\n3. You can maximum upload 3 vehicle images.", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      SizedBox(height: 8),
      GestureDetector(
        onTap: _pickImages,
        child: Container(
          height: 120, // Increased height to accommodate delete button
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
          child: _vehicleImages.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload, size: 40, color: Colors.grey),
                    Text('Choose Image/s', style: TextStyle(color: Colors.grey)),
                  ],
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _vehicleImages.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(_vehicleImages[index], height: 100, width: 100, fit: BoxFit.cover),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => _removeImage(index),
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.close, color: Colors.white, size: 18),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ),
      ),
    ],
  );
}

void _removeImage(int index) {
  setState(() {
    _vehicleImages.removeAt(index);
  });
}

  Widget _buildTextField(String label, String hint, TextEditingController controller, {int? maxLength}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      Text(hint, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      SizedBox(height: 8),
      TextFormField(
        controller: controller,
        maxLines: null, // Allows the text field to expand
        minLines: 1,    // Minimum number of lines
        keyboardType: TextInputType.multiline,
        maxLength: maxLength,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!)),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
      ),
      SizedBox(height: 16),
    ],
  );
}

  Widget _buildDropdown(String label, String hint, List<dynamic> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      Text(hint, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!)),
        ),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: label.contains('Category') ? item['id'].toString() : item['districts_name'],
            child: Text(item['name'] ?? item['districts_name'] ?? ''),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            if (label.contains('Category')) {
              _selectedCategory = newValue ?? '';
            } else if (label.contains('District')) {
              _selectedDistrict = newValue ?? '';
            } else if (label.contains('City')) {
              _selectedCity = newValue ?? '';
            }
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select an option';
          }
          return null;
        },
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
                controller: _priceController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!)),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
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
                items: ['km', 'mile'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value == 'km' ? 'Per Km' : 'Per Mile'),
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

void _submitForApproval() async {
  if (_formKey.currentState?.validate() ?? false) {
    if (_vehicleImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please upload at least one image')),
      );
      return;
    }

    final vehicleData = {
      'name': _nameController.text,
      'description': _descriptionController.text,
      'price': _priceController.text,
      'category_id': _selectedCategory,
      'area': _selectedDistrict,
      'pay_type': _priceUnit,
      'city': _selectedCity,
    };

    try {
      await Provider.of<VehicleProvider>(context, listen: false).createNewVehicle(vehicleData, _vehicleImages);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vehicle submitted for approval successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error submitting vehicle: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit vehicle: $e')),
      );
    }
  }
}
}