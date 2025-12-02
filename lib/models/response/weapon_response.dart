import 'package:elden_ring_app/models/modelos.dart';

//Clase que representa la respuesta completa de la API al solicitar todas las armas
class WeaponsResponse {
  final bool success; //Indica si la petición se completó con éxito
  final int count; //Número total de armas devueltas
  final List<Weapon> data;    //Lista con todas las armas obtenidas

  WeaponsResponse({required this.success, required this.count, required this.data});

  factory WeaponsResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    return WeaponsResponse(
      success: json['success'] as bool,
      count: json['count'] as int,
      data: list.map((e) => Weapon.fromJson(e)).toList(),
    );
  }
}