//Clase que representa la defensa de un arma o escudo contra un tipo concreto de daño
class DefensePower {
  final String name; //Tipo de daño que se defiende (Phys, Magic, Fire, Lightning, Holy...)
  final int amount; //Cantidad de defensa que ofrece contra ese tipo de daño

  DefensePower({required this.name, required this.amount});

  factory DefensePower.fromJson(Map<String, dynamic> json) {
    return DefensePower(
      name: json['name'] as String,
      amount: json['amount'] as int,
    );
  }
}