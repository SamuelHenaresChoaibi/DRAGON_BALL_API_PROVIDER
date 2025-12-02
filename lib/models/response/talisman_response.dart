import 'package:elden_ring_app/models/modelos.dart';

//Clase que representa la respuesta completa de la API al solicitar todos los talismanes
class TalismansResponse {
  final bool success; //Indica si la petición se completó con éxito
  final int count; //Número total de talismanes devueltos
  final List<Talisman> data; //Lista con todos los talismanes obtenidos

  TalismansResponse({
    required this.success,
    required this.count,
    required this.data,
  });

  factory TalismansResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    return TalismansResponse(
      success: json['success'] as bool,
      count: json['count'] as int,
      data: list.map((e) => Talisman.fromJson(e)).toList(),
    );
  }
}