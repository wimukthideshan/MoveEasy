// user_model.dart
class User {
  final String name;
  final String gender;
  final int age;
  final String homeTown;
  final String bio;
  final String email;
  final int whatsAppNumber;
  final int phoneNumber;
  final String address;
  final String city;
  final String? profileImageUrl;

  User({
    required this.name,
    this.gender = '',
    this.age = 0,
    this.homeTown = '',
    this.bio = '',
    required this.email,
    this.whatsAppNumber = 0,
    this.phoneNumber = 0,
    this.address = '',
    this.city = '',
    this.profileImageUrl,
  });
}