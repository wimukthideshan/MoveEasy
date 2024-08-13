// import 'package:moveeasy/Model/user_model.dart';
// import 'package:moveeasy/Model/category_model.dart';

// class Vehicle {
//   final int id;
//   final String name;
//   final String slug;
//   final String description;
//   final String status;
//   final int categoryId;
//   final int userId;
//   final double price;
//   final String payType;
//   final String area;
//   final String city;
//   final String createdAt;
//   final String updatedAt;
//   final String createdAtHuman;
//   final bool isFavorite;
//   final int? favoriteId;
//   final dynamic mainImage;
//   final User user;
//   final Category? category;
//   final List<String>? thumbImages;
//   final List<dynamic> images;
  

//   Vehicle ({
//     required this.id,
//     required this.name,
//     required this.slug,
//     required this.description,
//     required this.status,
//     required this.categoryId,
//     required this.userId,
//     required this.price,
//     required this.payType,
//     required this.area,
//     required this.city,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.createdAtHuman,
//     required this.isFavorite,
//     this.favoriteId,
//     this.mainImage,
//     required this.user,
//     this.category,
//     this.thumbImages,
//     required this.images,
//   });

//   factory Vehicle.fromJson(Map<String, dynamic> json) {
//     return Vehicle(
//       id: json['id'],
//       name: json['name'],
//       slug: json['slug'],
//       description: json['description'],
//       status: json['status'],
//       categoryId: json['category_id'],
//       userId: json['user_id'],
//       price: double.parse(json['price'].toString()),
//       payType: json['pay_type'],
//       area: json['area'],
//       city: json['city'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       createdAtHuman: json['created_at_human'],
//       isFavorite: json['is_favorite'] ?? false,
//       favoriteId: json['favorite_id'],
//       mainImage: json['main_image'],
//       user: User.fromJson(json['user']),
//       category: json['category'] != null ? Category.fromJson(json['category']) : null,
//       images: json['images'] ?? [json['main_image']],
//     );
//   }


//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'slug': slug,
//       'description': description,
//       'status': status,
//       'category_id': categoryId,
//       'user_id': userId,
//       'price': price,
//       'pay_type': payType,
//       'area': area,
//       'city': city,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'created_at_human': createdAtHuman,
//       'is_favorite': isFavorite,
//       'favorite_id': favoriteId,
//       'main_image': mainImage,
//       'user': user.toJson(),
//       'category': category?.toJson(),
//       'thumb_images': thumbImages,
//       'images': images,
//     };
//   }

//   String get mainImageUrl {
//   if (mainImage is Map && mainImage['url'] != null) {
//     return 'https://moveazy.axcertro.dev${mainImage['url']}';
//   } else if (mainImage is String) {
//     return 'https://moveazy.axcertro.dev$mainImage';
//   }
//   return 'https://via.placeholder.com/150';
// }
// }

import 'package:moveeasy/Model/user_model.dart';
import 'package:moveeasy/Model/category_model.dart';

class Vehicle {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String status;
  final int categoryId;
  final int userId;
  final double price;
  final String payType;
  final String area;
  final String city;
  final String createdAt;
  final String updatedAt;
  final String createdAtHuman;
  final bool isFavorite;
  final int? favoriteId;
  final dynamic mainImage;
  final User user;
  final Category? category;
  final List<String>? thumbImages;
  final List<dynamic> images;

  Vehicle({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.status,
    required this.categoryId,
    required this.userId,
    required this.price,
    required this.payType,
    required this.area,
    required this.city,
    required this.createdAt,
    required this.updatedAt,
    required this.createdAtHuman,
    required this.isFavorite,
    this.favoriteId,
    this.mainImage,
    required this.user,
    this.category,
    this.thumbImages,
    required this.images,
  });

  Vehicle copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    String? status,
    int? categoryId,
    int? userId,
    double? price,
    String? payType,
    String? area,
    String? city,
    String? createdAt,
    String? updatedAt,
    String? createdAtHuman,
    bool? isFavorite,
    int? favoriteId,
    dynamic mainImage,
    User? user,
    Category? category,
    List<String>? thumbImages,
    List<dynamic>? images,
  }) {
    return Vehicle(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      status: status ?? this.status,
      categoryId: categoryId ?? this.categoryId,
      userId: userId ?? this.userId,
      price: price ?? this.price,
      payType: payType ?? this.payType,
      area: area ?? this.area,
      city: city ?? this.city,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAtHuman: createdAtHuman ?? this.createdAtHuman,
      isFavorite: isFavorite ?? this.isFavorite,
      favoriteId: favoriteId ?? this.favoriteId,
      mainImage: mainImage ?? this.mainImage,
      user: user ?? this.user,
      category: category ?? this.category,
      thumbImages: thumbImages ?? this.thumbImages,
      images: images ?? this.images,
    );
  }

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      status: json['status'],
      categoryId: json['category_id'],
      userId: json['user_id'],
      price: double.parse(json['price'].toString()),
      payType: json['pay_type'],
      area: json['area'],
      city: json['city'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdAtHuman: json['created_at_human'],
      isFavorite: json['is_favorite'] ?? false,
      favoriteId: json['favorite_id'],
      mainImage: json['main_image'],
      user: User.fromJson(json['user']),
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
      thumbImages: json['thumb_images'] != null ? List<String>.from(json['thumb_images']) : null,
      images: json['images'] ?? [json['main_image']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'status': status,
      'category_id': categoryId,
      'user_id': userId,
      'price': price,
      'pay_type': payType,
      'area': area,
      'city': city,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_at_human': createdAtHuman,
      'is_favorite': isFavorite,
      'favorite_id': favoriteId,
      'main_image': mainImage,
      'user': user.toJson(),
      'category': category?.toJson(),
      'thumb_images': thumbImages,
      'images': images,
    };
  }

  String get mainImageUrl {
    if (mainImage is Map && mainImage['url'] != null) {
      return 'https://moveazy.axcertro.dev${mainImage['url']}';
    } else if (mainImage is String) {
      return 'https://moveazy.axcertro.dev$mainImage';
    }
    return 'https://via.placeholder.com/150';
  }
}