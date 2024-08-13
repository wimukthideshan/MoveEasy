import 'package:flutter/material.dart';
import 'package:moveeasy/Model/user_model.dart';
import 'package:moveeasy/Service/user_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final UserService _userService = UserService();
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchUser() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _user = await _userService.fetchUserProfile();
    } catch (e) {
      _error = e.toString();
      print('Error fetching user: $_error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateUser(User updatedUser) {
    _user = updatedUser;
    notifyListeners();
  }

  void updateProfileImage(String newAvatarUrl) {
    if (_user != null) {
      _user = User(
        id: _user!.id,
        name: _user!.name,
        email: _user!.email,
        mobile: _user!.mobile,
        mobileVerifiedAt: _user!.mobileVerifiedAt,
        emailVerifiedAt: _user!.emailVerifiedAt,
        otp: _user!.otp,
        status: _user!.status,
        role: _user!.role,
        serviceProviderType: _user!.serviceProviderType,
        trailPeriodTime: _user!.trailPeriodTime,
        createdAt: _user!.createdAt,
        updatedAt: _user!.updatedAt,
        createdAtHuman: _user!.createdAtHuman,
        avatar: newAvatarUrl,
        cover: _user!.cover,
        freeServiceAvailable: _user!.freeServiceAvailable,
        trailPeriodEndTime: _user!.trailPeriodEndTime,
        providerAssessDate: _user!.providerAssessDate,
        mobiles: _user!.mobiles,
        metaData: _user!.metaData,
      );
      notifyListeners();
    }
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}