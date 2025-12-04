class Planet {
  final int id;
  final String name;
  final bool isDestroyed;
  final String description;
  final String image;
  final String? deletedAt;

  Planet({
    required this.id,
    required this.name,
    required this.isDestroyed,
    required this.description,
    required this.image,
    this.deletedAt,
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      id: json['id'] as int,
      name: json['name'] as String,
      isDestroyed: json['isDestroyed'] as bool,
      description: json['description'] as String,
      image: json['image'] as String,
      deletedAt: json['deletedAt'] as String?,
    );
  }

  String get imageUrl => image.isNotEmpty
      ? image
      : 'https://via.placeholder.com/300x400.png?text=No+Image';
}