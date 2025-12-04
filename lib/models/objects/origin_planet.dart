class OriginPlanet {
  final int id;
  final String name;
  final bool isDestroyed;
  final String description;
  final String? image;

  OriginPlanet({
    required this.id,
    required this.name,
    required this.isDestroyed,
    required this.description,
    this.image,
  });

  factory OriginPlanet.fromJson(Map<String, dynamic> json) {
    return OriginPlanet(
      id: json['id'] as int,
      name: json['name'] as String,
      isDestroyed: json['isDestroyed'] as bool,
      description: json['description'] as String,
      image: json['image'] as String?,
    );
  }
}