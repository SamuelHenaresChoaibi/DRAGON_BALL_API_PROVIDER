import 'package:elden_ring_app/models/modelos.dart';

//Clase que representa la respuesta completa de la API al solicitar todas las Cenizas de Espíritu
class SpiritsResponse {
  final bool success; //Indica si la petición fue exitosa
  final int count; //Número total de espíritus devueltos
  final List<Spirit> data; //Lista con todos los espíritus obtenidos

  SpiritsResponse({
    required this.success,
    required this.count,
    required this.data,
  });

  factory SpiritsResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    return SpiritsResponse(
      success: json['success'] as bool,
      count: json['count'] as int,
      data: list.map((e) => Spirit.fromJson(e)).toList(),
    );
  }
}