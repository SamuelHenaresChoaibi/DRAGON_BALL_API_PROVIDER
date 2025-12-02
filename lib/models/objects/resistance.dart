//Clase que representa la resistencia a efectos de estado de una armadura o personaje
class Resistance {
  final String name; //Tipo de efecto de estado (Poison, Scarlet Rot, Bleed, Frostbite, Sleep, Madness, Death Blight)
  final int amount; //Cantidad de resistencia frente a ese efecto (a mayor valor, más difícil de aplicar)

  Resistance({required this.name, required this.amount});

  factory Resistance.fromJson(Map<String, dynamic> json) {
    return Resistance(
      name: json['name'] as String,
      amount: json['amount'] as int,
    );
  }
}