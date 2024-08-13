// lib/Service/api_service.dart

import 'package:http/http.dart' as http;
import 'package:moveeasy/Model/user_model.dart';
import 'package:moveeasy/Model/vehicle_model.dart';
import 'dart:convert';
import 'package:moveeasy/Service/auth_storage.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

class ApiService {
  static const String baseUrl = 'https://moveazy.axcertro.dev/api'; //development server


  

  //Forgot Password Reset
  Future<bool> forgotPasswordReset(String phoneNumber) async {
    final response = await http.post(
      Uri.parse('$baseUrl/forgot-password-reset'),
      body: json.encode({'phone_number': phoneNumber}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Successfully initiated password reset
      return true;
    } else {
      // Handle error cases
      throw Exception('Failed to initiate password reset: ${response.body}');
    }
  }

  //Login
  Future<String> login(String mobile, String password) async {
    final client = http.Client();
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'mobile': mobile,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // The response is the token itself, not JSON
        // return response.body.trim();
        final token = response.body.trim();
        await AuthStorage.saveToken(token);
        return token;
      } else {
        throw Exception('Login failed: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error in login API call: $e');
      throw Exception('Login failed: $e');
    } finally {
      client.close();
    }
  }

  //Register
  Future<String> register(String name, String mobile, String password, String passwordConfirmation) async {
    final client = http.Client();
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'mobile': mobile,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // The response is the token itself, not JSON
        // return response.body.trim();
        final token = response.body.trim();
        await AuthStorage.saveToken(token);
        return token;
      } else {
        throw Exception('Registration failed: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error in register API call: $e');
      throw Exception('Registration failed: $e');
    } finally {
      client.close();
    }
  }


  //logout
  Future<void> logout() async {
    await AuthStorage.deleteToken();
  }

  Future<String?> getStoredToken() async {
    return await AuthStorage.getToken();
  }


  //Get User Profile
  Future<User> getCurrentUser() async {
  final token = await AuthStorage.getToken();
  if (token == null) {
    throw Exception('No token found');
  }

  final response = await http.get(
    Uri.parse('$baseUrl/user'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    return User.fromJson(responseData['user']);
  } else {
    throw Exception('Failed to load user data');
  }
}


//Load Vehicles
Future<Map<String, dynamic>> fetchFilteredVehicles(int perPage, int page) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/services/filter-data?perPage=$perPage&page=$page'),
        headers: {'Accept': 'application/json'},
        body: {'sortBy': 'id'},
      );
      print('Filtered vehicles response: ${response.body}');
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      return {'services': {'secondLevel': []}};
    } catch (e) {
      print("Error in fetchFilteredVehicles: $e");
      return {'services': {'secondLevel': []}};
    }
  }

//Paid Vehicles
Future<List<Vehicle>> fetchPaidVehicles() async {
    final response = await http.get(Uri.parse('$baseUrl/services/paid-services'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> servicesJson = data['services'];
      return servicesJson.map((json) => Vehicle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load paid vehicles');
    }
  }

  Future<Map<String, dynamic>> getFilterParams() async {
    final response = await http.get(Uri.parse('$baseUrl/services/filter-params'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load filter parameters');
    }
  }

//add a new vehicle
Future<void> createVehicle(Map<String, dynamic> vehicleData, List<File> images) async {
  try {
    final token = await AuthStorage.getToken();
    if (token == null) throw Exception('No token found');

    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/services/create'));
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';

    // Add text fields
    vehicleData.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    // Add images
    if (images.isNotEmpty) {
      // Add main image
      var mainImage = images[0];
      var mainStream = http.ByteStream(mainImage.openRead());
      var mainLength = await mainImage.length();
      var mainMultipartFile = http.MultipartFile(
        'main_image[image]',
        mainStream,
        mainLength,
        filename: mainImage.path.split("/").last
      );
      request.files.add(mainMultipartFile);

      // Add additional images as thumbs
      for (int i = 1; i < images.length; i++) {
        var thumbImage = images[i];
        var thumbStream = http.ByteStream(thumbImage.openRead());
        var thumbLength = await thumbImage.length();
        var thumbMultipartFile = http.MultipartFile(
          'main_image[thumb][]',
          thumbStream,
          thumbLength,
          filename: thumbImage.path.split("/").last
        );
        request.files.add(thumbMultipartFile);
      }
    } else {
      throw Exception('At least one image is required');
    }

    print('DEBUG: Sending request to ${request.url}');
    print('DEBUG: Request headers: ${request.headers}');
    print('DEBUG: Request fields: ${request.fields}');
    print('DEBUG: Request files: ${request.files}');

    var response = await request.send();
    print('DEBUG: Response status: ${response.statusCode}');
    
    var responseBody = await response.stream.bytesToString();
    print('DEBUG: Response body: $responseBody');

    if (response.statusCode != 200) {
      throw Exception('Failed to create vehicle: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('DEBUG: Error in ApiService.createVehicle: $e');
    rethrow;
  }
}

//get the users vehicles(my services)
Future<Map<String, dynamic>> fetchUserVehicles() async {
    final token = await AuthStorage.getToken();
    if (token == null) throw Exception('No token found');

    final response = await http.get(
      Uri.parse('$baseUrl/services/my-services'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user vehicles');
    }
  }

  Future<void> addToFavorites(int serviceId) async {
    final token = await AuthStorage.getToken();
    if (token == null) throw Exception('No token found');

    final response = await http.post(
      Uri.parse('$baseUrl/fav/add'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'service_id': serviceId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add to favorites');
    }
  }

  Future<void> removeFromFavorites(int favoriteId) async {
    final token = await AuthStorage.getToken();
    if (token == null) throw Exception('No token found');

    final response = await http.delete(
      Uri.parse('$baseUrl/fav/$favoriteId/remove'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove from favorites');
    }
  }

  Future<List<Vehicle>> getFavoriteVehicles() async {
    final token = await AuthStorage.getToken();
    if (token == null) throw Exception('No token found');

    final response = await http.get(
      Uri.parse('$baseUrl/fav/list'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> favoritesJson = data['favorites'];
      return favoritesJson.map((json) => Vehicle.fromJson(json['service'])).toList();
    } else {
      throw Exception('Failed to load favorite vehicles');
    }
  }
}

