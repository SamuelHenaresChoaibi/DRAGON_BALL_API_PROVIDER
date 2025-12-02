import 'package:elden_ring_app/models/modelos.dart';

//Clase que representa un hechizo (sorcery) del juego
class Sorcery {
  final String id; //ID único del hechizo
  final String name; //Nombre del hechizo
  final String image; //URL de la imagen del hechizo
  final String description; //Descripción/lore del hechizo
  final String type; //Tipo de hechizo (por ejemplo: "Glintstone Sorcery")
  final int cost; //Costo en FP para lanzar el hechizo
  final int slots; //Número de ranuras de memoria que ocupa
  final String effects; //Efectos del hechizo (texto descriptivo)
  final List<StatRequirement> requires; //Requisitos de atributos para poder lanzarlo

  Sorcery({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.type,
    required this.cost,
    required this.slots,
    required this.effects,
    required this.requires,
  });

  factory Sorcery.fromJson(Map<String, dynamic> json) {
    var reqList = json['requires'] as List;

    return Sorcery(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      cost: json['cost'] as int,
      slots: json['slots'] as int,
      effects: json['effects'] as String,
      requires: reqList.map((e) => StatRequirement.fromJson(e)).toList(),
    );
  }

  // Getters para obtener rápidamente los requisitos más comunes
  int get intRequired => requires.firstWhere((r) => r.name == "Intelligence", orElse: () => StatRequirement(name: "Intelligence", amount: 0)).amount;
  int get faithRequired => requires.firstWhere((r) => r.name == "Faith", orElse: () => StatRequirement(name: "Faith", amount: 0)).amount;
  int get arcaneRequired => requires.firstWhere((r) => r.name == "Arcane", orElse: () => StatRequirement(name: "Arcane", amount: 0)).amount;

  @override
  String toString() => 'Sorcery{name: $name, INT: $intRequired, Cost: $cost FP}';
}