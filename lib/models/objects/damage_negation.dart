//Clase que representa la negación de daño de una armadura frente a un tipo concreto
class DamageNegation {
  final String name; //Tipo de daño que se niega (Phy, Mag, Fire, Lightning, Holy...)
  final double amount; //Porcentaje o valor de reducción del daño recibido (valor decimal)

  DamageNegation({required this.name, required this.amount});

  factory DamageNegation.fromJson(Map<String, dynamic> json) {
    return DamageNegation(
      name: json['name'] as String,
      amount: (json['amount'] is int)
          ? (json['amount'] as int).toDouble()
          : json['amount'] as double,
    );
  }
}