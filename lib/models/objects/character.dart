import 'package:dragon_ball_provider/models/modelos.dart';

class Character {
  final int id;
  final String name;
  final String ki;
  final String maxKi;
  final String race;
  final String gender;
  final String description;
  final String image;
  final String affiliation;
  final String? deletedAt;
  final OriginPlanet? originPlanet;  

  Character({
    required this.id,
    required this.name,
    required this.ki,
    required this.maxKi,
    required this.race,
    required this.gender,
    required this.description,
    required this.image,
    required this.affiliation,
    this.deletedAt,
    this.originPlanet,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] as int,
      name: json['name'] as String,
      ki: json['ki'] as String,
      maxKi: json['maxKi'] as String,
      race: json['race'] as String,
      gender: json['gender'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      affiliation: json['affiliation'] as String,
      deletedAt: json['deletedAt'] as String?,
      originPlanet: json['originPlanet'] != null
          ? OriginPlanet.fromJson(json['originPlanet'])
          : null,
    );
  }
}