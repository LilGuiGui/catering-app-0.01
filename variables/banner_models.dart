// banner_models.dart
class Banner {
  final String? id;
  final String? imageUrl;
  final bool? isActive;
  final String? description;

  Banner({
    this.id,
    this.imageUrl,
    this.description,
    this.isActive,
  });

  factory Banner.fromMap(Map<String, dynamic> data) {
    return Banner(
      id: data['id'] as String?,
      imageUrl: data['image_url'] as String?,
      description: data['description'] as String?,
      isActive: data['is_active'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image_url': imageUrl,
      'description': description,
      'is_active': isActive,
    };
  }
}
 