// user_provider.dart
import 'package:flutter/material.dart';
import 'package:moveeasy/Model/user_model.dart';


class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void updateProfileImage(String imagePath) {
    if (_user != null) {
      _user = User(
        name: _user!.name,
        email: _user!.email,
        whatsAppNumber: _user!.whatsAppNumber,
        gender: _user!.gender,
        age: _user!.age,
        homeTown: _user!.homeTown,
        bio: _user!.bio,
        phoneNumber: _user!.phoneNumber,
        address: _user!.address,
        city: _user!.city,
        profileImageUrl: imagePath,
      );
      notifyListeners();
    }
  }
}