//Clase que representa el escalado de un arma con un atributo concreto
class Scaling { 
  final String name; //Nombre del atributo que escala (Str, Dex, Int, Fai, Arc)
  final String scaling; //Grado de escalado del arma con ese atributo (S, A, B, C, D, E, - o vacío)

  Scaling({required this.name, required this.scaling});

  factory Scaling.fromJson(Map<String, dynamic> json) => Scaling(
        name: json['name'] as String,
        scaling: json['scaling'] as String? ?? '',
      );
}