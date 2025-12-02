//Clase que representa un requisito de atributo para usar hechizos, armas o invocaciones
class StatRequirement {
  final String name; //Nombre del atributo requerido (Intelligence, Faith, Arcane, Strength, Dexterity...)
  final int amount; //Cantidad mínima necesaria del atributo para poder usar el objeto

  StatRequirement({required this.name, required this.amount});

  factory StatRequirement.fromJson(Map<String, dynamic> json) {
    return StatRequirement(
      name: json['name'] as String,
      amount: json['amount'] as int,
    );
  }
}