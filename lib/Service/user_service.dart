// user_service.dart
import 'package:moveeasy/Model/user_model.dart';
import 'package:moveeasy/Service/api_service.dart';


class UserService {
  final ApiService _apiService = ApiService();

  Future<User> fetchUserProfile() async {
    try {
      return await _apiService.getCurrentUser();
    } catch (e) {
      print('Error fetching user profile: $e');
      rethrow;
    }
    // return User(
    //   name: 'Shan',
    //   email: 'shan123@gmail.com',
    //   whatsAppNumber: 0714753588
    //   // Other fields can be left as default
    // );
  }
}