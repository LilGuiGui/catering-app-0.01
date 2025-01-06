class Menu {
  final String? name;
  final double? price;
  final bool? availability;
  final String? imageUrl;
  final String? description;

  Menu({
    this.name,
    this.price,
    this.availability,
    this.imageUrl,
    this.description,
  });

  factory Menu.fromMap(Map<String, dynamic> data) {
    return Menu(
      name: data['name'] as String?,
      price: (data['price'] is int) 
          ? (data['price'] as int).toDouble() 
          : (data['price'] as num?)?.toDouble(),
      availability: data['avail'] as bool?,
      imageUrl: data['image_url'] as String?,
      description: data['desc'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'avail': availability,
      'image_url': imageUrl,
      'desc': description,
    };
  }
}