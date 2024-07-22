// user_service.dart
import 'package:moveeasy/Model/user_model.dart';


class UserService {
  Future<User> fetchUserProfile() async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

  
    
    return User(
      name: 'Shan',
      email: 'shan123@gmail.com',
      whatsAppNumber: 0714753588
      // Other fields can be left as default
    );
  }
}