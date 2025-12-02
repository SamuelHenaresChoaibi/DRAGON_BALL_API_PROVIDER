//Clase que representa un atributo necesario para equipar o usar un arma
class RequiredAttribute {
  final String name; //Nombre del atributo requerido (Str, Dex, Int, Fai, Arc)
  final int amount; //Cantidad mínima del atributo que el personaje debe tener para poder usar el arma

  RequiredAttribute({required this.name, required this.amount});

  factory RequiredAttribute.fromJson(Map<String, dynamic> json) => RequiredAttribute(
        name: json['name'] as String,
        amount: json['amount'] as int,
      );
}