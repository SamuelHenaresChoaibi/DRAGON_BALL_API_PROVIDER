import 'package:elden_ring_app/models/modelos.dart';

//Clase que representa la respuesta completa de la API al pedir todas las armaduras
class ArmorResponse {
  final bool success; //Indica si la petición fue exitosa
  final int count; //Número total de armaduras devueltas
  final List<Armor> data; //Lista con todas las armaduras obtenidas

  ArmorResponse({
    required this.success,
    required this.count,
    required this.data,
  });

  factory ArmorResponse.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<Armor> armors = dataList.map((item) => Armor.fromJson(item)).toList();

    return ArmorResponse(
      success: json['success'] as bool,
      count: json['count'] as int,
      data: armors,
    );
  }
}