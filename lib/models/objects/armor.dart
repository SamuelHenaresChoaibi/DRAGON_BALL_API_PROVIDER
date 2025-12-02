import 'package:elden_ring_app/models/modelos.dart';

//Clase que representa una armadura de Elden Ring
class Armor {
  final String id; //ID único de la armadura
  final String name; //Nombre de la armadura
  final String image; //URL de la imagen de la armadura
  final String description; //Descripción/lore de la armadura
  final String category; //Categoría (Casco, Pecho, Guantes, Grebas)
  final List<DamageNegation> dmgNegation; //Negación de daño físico, mágico, etc.
  final List<Resistance> resistance; //Resistencias a efectos de estado
  final double weight; //Peso de la pieza de armadura

  Armor({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.category,
    required this.dmgNegation,
    required this.resistance,
    required this.weight,
  });

  factory Armor.fromJson(Map<String, dynamic> json) {
    var dmgList = json['dmgNegation'] as List;
    var resList = json['resistance'] as List;

    return Armor(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      dmgNegation: dmgList.map((i) => DamageNegation.fromJson(i)).toList(),
      resistance: resList.map((i) => Resistance.fromJson(i)).toList(),
      weight: (json['weight'] is int)
          ? (json['weight'] as int).toDouble()
          : json['weight'] as double,
    );
  }
}