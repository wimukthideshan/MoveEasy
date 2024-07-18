// my_profile_page.dart
import 'package:flutter/material.dart';
import 'package:moveeasy/Model/user_model.dart';
import 'package:moveeasy/Provider/user_provider.dart';
import 'package:moveeasy/Service/user_service.dart';
import 'package:provider/provider.dart';
import 'package:moveeasy/components/app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final user = await _userService.fetchUserProfile();
    Provider.of<UserProvider>(context, listen: false).setUser(user);
  }

Future<void> _pickAndCropImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.teal,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioLockEnabled: true,
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        Provider.of<UserProvider>(context, listen: false).updateProfileImage(croppedFile.path);
      });
    }
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: CustomAppBar(title: 'Your Profile'),
    backgroundColor: Colors.grey[100],
    body: Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final user = userProvider.user;
        if (user == null) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(user),
              _buildInfoSection('Basic Information', [
                _buildInfoItem('Name', user.name),
                _buildInfoItem('Gender', user.gender),
                _buildInfoItem('Age', user.age.toString()),
                _buildInfoItem('Home Town', user.homeTown),
              ]),
              _buildInfoSection('Bio Information', [
                _buildInfoItem('Bio', user.bio),
              ]),
              _buildInfoSection('Contacts Information', [
                _buildInfoItem('Email', user.email),
                _buildInfoItem('WhatsApp Number', user.whatsAppNumber.toString()),
                _buildInfoItem('Phone Number', user.phoneNumber.toString()),
                _buildInfoItem('Address', user.address),
                _buildInfoItem('City', user.city),
              ]),
              _buildSecuritySection(),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  child: Text('Log Out'),
                  onPressed: () {
                    // Implement log out functionality
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    ),
  );
}

Widget _buildProfileHeader(User user) {
  return Container(
    padding: EdgeInsets.all(20),
    child: Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.teal,
              backgroundImage: user.profileImageUrl != null
                  ? NetworkImage(user.profileImageUrl!)
                  : null,
              child: user.profileImageUrl == null
                  ? Text(
                      user.name.substring(0, 2).toUpperCase(),
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    )
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: _pickAndCropImage,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.camera_alt, color: Colors.teal),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          user.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget _buildInfoSection(String title, List<Widget> items) {
  return Card(
    margin: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                child: Text('Edit'),
                onPressed: () {
                  // Implement edit functionality
                },
              ),
            ],
          ),
        ),
        ...items,
      ],
    ),
  );
}

Widget _buildInfoItem(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      children: [
        Expanded(child: Text(label, style: TextStyle(color: Colors.grey))),
        Expanded(child: Text(value.isEmpty ? 'Not Provided' : value, textAlign: TextAlign.right)),
      ],
    ),
  );
}

Widget _buildSecuritySection() {
  return Card(
    margin: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text('Security', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextButton(
            child: Text('Reset Password'),
            onPressed: () {
              // Implement reset password functionality
            },
          ),
        ),
      ],
    ),
  );
}
}