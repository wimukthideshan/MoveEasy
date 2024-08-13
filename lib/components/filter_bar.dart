import 'package:flutter/material.dart';
import 'package:moveeasy/Provider/vehicle_provider.dart';
import 'package:moveeasy/components/category_picker.dart';
import 'package:moveeasy/components/location_picker.dart';
import 'package:provider/provider.dart';

class FilterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<VehicleProvider>(
      builder: (context, vehicleProvider, child) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
          ),
          child: Row(
            children: [
              _buildFilterItem(
                icon: Icons.location_on,
                text: vehicleProvider.selectedLocation.isEmpty
                    ? 'Location'
                    : vehicleProvider.selectedLocation,
                onTap: () => _showLocationPicker(context),
              ),
              VerticalDivider(color: Colors.grey[300]),
              _buildFilterItem(
                icon: Icons.category,
                text: vehicleProvider.selectedCategory.isEmpty
                    ? 'Category'
                    : vehicleProvider.selectedCategory,
                onTap: () => _showCategoryPicker(context),
              ),
              VerticalDivider(color: Colors.grey[300]),
              _buildFilterItem(
                icon: Icons.tune,
                text: 'Filters',
                onTap: () {
                  // Implement additional filters if needed
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.red),
            SizedBox(width: 4),
            Flexible(
              child: Text(
                text,
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLocationPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => LocationPickerWidget(),
    );
  }

  void _showCategoryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => CategoryPickerWidget(),
    );
  }
}