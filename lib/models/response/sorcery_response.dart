import 'package:elden_ring_app/models/modelos.dart';

//Clase que representa la respuesta completa de la API al solicitar todos los hechizos (sorceries)
class SorceriesResponse {
  final bool success; //Indica si la petición se completó con éxito
  final int count; //Número total de hechizos devueltos
  final List<Sorcery> data; //Lista con todos los hechizos obtenidos

  SorceriesResponse({required this.success, required this.count, required this.data});

  factory SorceriesResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    return SorceriesResponse(
      success: json['success'] as bool,
      count: json['count'] as int,
      data: list.map((e) => Sorcery.fromJson(e)).toList(),
    );
  }
}