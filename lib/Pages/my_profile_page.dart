import 'package:flutter/material.dart';
import 'package:moveeasy/Model/user_model.dart';
import 'package:moveeasy/Provider/auth_provider.dart';
import 'package:moveeasy/Provider/user_provider.dart';
import 'package:moveeasy/components/loading_indicator.dart';
import 'package:moveeasy/components/login_required.dart';
import 'package:provider/provider.dart';
import 'package:moveeasy/components/app_bar.dart';


class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).checkAuthStatus();
      Provider.of<UserProvider>(context, listen: false).fetchUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Your Profile'),
      body: authProvider.isAuthenticated
          ? Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                if (userProvider.isLoading) {
                  return Center(child: LoadingIndicator());
                }
                if (userProvider.error != null) {
                  return Center(child: Text('Error: ${userProvider.error}'));
                }
                final user = userProvider.user;
                if (user == null) {
                  return Center(child: Text('No user data available'));
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildProfileHeader(user),
                      _buildInfoSection('Basic Information', [
                        _buildInfoItem('Name', user.name),
                        _buildInfoItem('Email', user.email),
                        _buildInfoItem('Mobile', user.mobile),
                        _buildInfoItem('Status', user.status),
                        _buildInfoItem('Role', user.role),
                      ]),
                      _buildInfoSection('Service Information', [
                        _buildInfoItem('Service Provider Type', user.serviceProviderType),
                        _buildInfoItem('Trial Period', '${user.trailPeriodTime} days'),
                        _buildInfoItem('Free Service Available', user.freeServiceAvailable ? 'Yes' : 'No'),
                      ]),
                      _buildInfoSection('Account Information', [
                        _buildInfoItem('Created At', user.createdAtHuman),
                        _buildInfoItem('Mobile Verified', user.mobileVerifiedAt != null ? 'Yes' : 'No'),
                        _buildInfoItem('Email Verified', user.emailVerifiedAt != null ? 'Yes' : 'No'),
                      ]),
                      _buildActionButtons(),
                    ],
                  ),
                );
              },
            )
          : LoginRequiredWidget(),
    );
  }

  Widget _buildProfileHeader(User user) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.teal,
            child: Text(
              user.name?.substring(0, 2).toUpperCase() ?? 'DE',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          SizedBox(height: 16),
          Text(
            user.name ?? 'No Name',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(user.role ?? 'No Role', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> items) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Divider(),
            ...items,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(value?.isNotEmpty == true ? value! : 'Not Provided', style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          ElevatedButton(
            child: Text('Edit Profile'),
            onPressed: () {
              // Implement edit profile functionality
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
            ),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            child: Text('Reset Password'),
            onPressed: () {
              // Implement reset password functionality
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[200],
              minimumSize: Size(double.infinity, 50),
            ),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            child: Text('Log Out', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).signOut(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }
}