// category_model.dart
class Category {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String? image;
  final String status;
  final String createdAt;
  final String updatedAt;
  final int? parentId;
  final String createdAtHuman;
  final String imageUrl;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.parentId,
    required this.createdAtHuman,
    required this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      image: json['image'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      parentId: json['parent_id'],
      createdAtHuman: json['created_at_human'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'image': image,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'parent_id': parentId,
      'created_at_human': createdAtHuman,
      'image_url': imageUrl,
    };
  }
}