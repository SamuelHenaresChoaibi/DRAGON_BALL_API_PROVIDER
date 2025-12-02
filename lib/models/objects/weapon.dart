import 'package:elden_ring_app/models/modelos.dart';

//Clase que representa un arma del juego
class Weapon {
  final String id; //ID único del arma
  final String name; //Nombre del arma
  final String image; //URL de la imagen del arma
  final String description; //Descripción/lore del arma
  final List<AttackPower> attack; //Daño base que inflige (físico, mágico, fuego…)
  final List<DefensePower> defence; //Defensas del arma cuando se usa para bloquear
  final List<Scaling> scalesWith; //Escalado del daño con los atributos del personaje
  final List<RequiredAttribute> requiredAttributes; //Requisitos mínimos de atributos para equiparla
  final String category; //Tipo de arma (Daga, Espada recta, Gran espada, Arco, etc.)
  final double weight; //Peso del arma (influye en el peso total del equipo)

  Weapon({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.attack,
    required this.defence,
    required this.scalesWith,
    required this.requiredAttributes,
    required this.category,
    required this.weight,
  });

  factory Weapon.fromJson(Map<String, dynamic> json) {
    return Weapon(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      attack: (json['attack'] as List).map((i) => AttackPower.fromJson(i)).toList(),
      defence: (json['defence'] as List).map((i) => DefensePower.fromJson(i)).toList(),
      scalesWith: (json['scalesWith'] as List).map((i) => Scaling.fromJson(i)).toList(),
      requiredAttributes: (json['requiredAttributes'] as List)
          .map((i) => RequiredAttribute.fromJson(i))
          .toList(),
      category: json['category'] as String,
      weight: json['weight'] is int
          ? (json['weight'] as int).toDouble()
          : json['weight'] as double,
    );
  }
}