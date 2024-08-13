// import 'package:image_picker/image_picker.dart';

// import 'dart:io';

// class ImagePickerService {
//   final ImagePicker _picker = ImagePicker();

//   Future<File?> pickImageFromGallery() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       return File(pickedFile.path);
//     } else {
//       return null;
//     }
//   }
// }


// In image_picker_service.dart

import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920, // Adjust as needed
      maxHeight: 1080, // Adjust as needed
      imageQuality: 85, // Adjust as needed (0-100)
    );

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      if (await isValidImage(file)) {
        return file;
      } else {
        print('Invalid image file');
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool> isValidImage(File file) async {
    // Check file size (e.g., limit to 5MB)
    const maxSizeInBytes = 5 * 1024 * 1024; // 5MB
    final fileSize = await file.length();
    if (fileSize > maxSizeInBytes) {
      print('File too large: ${fileSize / 1024 / 1024}MB');
      return false;
    }

    // Check file extension
    final validExtensions = ['.jpg', '.jpeg', '.png'];
    final extension = file.path.split('.').last.toLowerCase();
    if (!validExtensions.contains('.$extension')) {
      print('Invalid file extension: $extension');
      return false;
    }

    return true;
  }
}