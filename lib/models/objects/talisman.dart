//Clase que representa un talismán del juego
class Talisman {
  final String id; //ID único del talismán
  final String name; //Nombre del talismán
  final String image; //URL de la imagen del talismán
  final String description; //Descripción/lore del talismán
  final String effect; //Efecto que otorga al equiparlo

  Talisman({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.effect,
  });

  factory Talisman.fromJson(Map<String, dynamic> json) {
    return Talisman(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      effect: json['effect'] as String,
    );
  }

  @override
  String toString() => 'Talisman{name: $name}';
}