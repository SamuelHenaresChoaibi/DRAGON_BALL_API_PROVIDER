//Clase que representa una Ceniza de Espíritu invocable del juego
class Spirit {
  final String id; //ID único del espíritu
  final String name; //Nombre del espíritu (ej: Lhutel la Sin Cabeza)
  final String image; //URL de la imagen del espíritu
  final String description; //Descripción/lore del espíritu
  final int fpCost; //Costo en FP para invocarlo (puede ser 0)
  final int hpCost; //Costo en HP para invocarlo (algunos espíritus caros lo usan)
  final String effect; //Efecto o comportamiento del espíritu en combate

  Spirit({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.fpCost,
    required this.hpCost,
    required this.effect,
  });

  factory Spirit.fromJson(Map<String, dynamic> json) {
    return Spirit(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      fpCost: int.parse(json['fpCost'] as String),
      hpCost: int.parse(json['hpCost'] as String),
      effect: json['effect'] as String,
    );
  }

  @override
  String toString() => 'Spirit{name: $name, FP: $fpCost}';
}