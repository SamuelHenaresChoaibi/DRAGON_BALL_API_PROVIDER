//Clase que representa el daño de un arma
class AttackPower {
  final String name; //Nombre del tipo de daño (Phys, Magic, Fire, etc.)
  final int amount; //Cantidad de daño de ese tipo

  AttackPower({
    required this.name,
    required this.amount,
  });

  factory AttackPower.fromJson(Map<String, dynamic> json) {
    return AttackPower(
      name: json['name'] as String,
      amount: json['amount'] as int,
    );
  }
}