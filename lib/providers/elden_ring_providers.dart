import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:elden_ring_app/models/modelos.dart';

//Proveedor que gestiona toda la información de Elden Ring desde la API pública
class EldenRingProvider extends ChangeNotifier {
  final String _baseUrl = 'eldenring.fanapis.com'; //Dominio de la API
  final String _basePath = '/api';
  final String _limit = '20'; //Máximo de elementos por petición

  //Listas que almacenan todos los datos descargados
  List<Weapon> weapons = []; //Todas las armas
  List<Armor> armors = []; //Todas las armaduras
  List<Sorcery> sorceries = []; //Todos los hechizos
  List<Spirit> spirits = []; //Todas las cenizas de espíritu
  List<Talisman> talismans = []; //Todos los talismanes

  bool isLoading = true; //Controla el estado de carga global (para el spinner)

  //Constructor: inicia la carga de datos al crear el provider
  EldenRingProvider() {
    loadAllData();
  }

  //Método privado genérico para hacer peticiones GET y devolver JSON tipado
  Future<T> _getJsonData<T>(String endPoint, [Map<String, String>? queryParams]) async {
    final Map<String, String> defaultParams = {
      'limit': _limit,
      'page': '1',
    };

    if (queryParams != null) {
      defaultParams.addAll(queryParams);
    }

    final url = Uri.https(_baseUrl, '$_basePath/$endPoint', defaultParams);
    print(url);
    try {
      final response = await http.get(url);

      if (response.statusCode != 200) {
        return <dynamic>[] as T;
      }

      final Map<String, dynamic> decodedData = json.decode(response.body);
      return decodedData as T;
    } catch (e) {
      return <dynamic>[] as T;
    }
  }

  //Actualiza el estado de carga y notifica a los listeners
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  //Carga todos los datos en paralelo al iniciar la app
  Future<void> loadAllData() async {
    setLoading(true);

    await Future.wait([
      getWeapons(),
      getArmors(),
      getSorceries(),
      getSpirits(),
      getTalismans(),
    ]);

    setLoading(false);
  }

  //Obtiene todas las armas desde la API y actualiza la lista
  Future<void> getWeapons({int page = 1}) async {
    final jsonData = await _getJsonData<Map<String, dynamic>>('weapons', {'page': page.toString()});
    final response = WeaponsResponse.fromJson(jsonData);
    weapons = response.data;
    notifyListeners();
  }

  //Obtiene todas las armaduras desde la API y actualiza la lista
  Future<void> getArmors({int page = 1}) async {
    final jsonData = await _getJsonData<Map<String, dynamic>>('armors', {'page': page.toString()});
    final response = ArmorResponse.fromJson(jsonData);
    armors = response.data;
    notifyListeners();
  }

  //Obtiene todos los hechizos desde la API y actualiza la lista
  Future<void> getSorceries({int page = 1}) async {
    final jsonData = await _getJsonData<Map<String, dynamic>>('sorceries', {'page': page.toString()});
    final response = SorceriesResponse.fromJson(jsonData);
    sorceries = response.data;
    notifyListeners();
  }

  //Obtiene todas las cenizas de espíritu desde la API y actualiza la lista
  Future<void> getSpirits({int page = 1}) async {
    final jsonData = await _getJsonData<Map<String, dynamic>>('spirits', {'page': page.toString()});
    final response = SpiritsResponse.fromJson(jsonData);
    spirits = response.data;
    notifyListeners();
  }

  //Obtiene todos los talismanes desde la API y actualiza la lista
  Future<void> getTalismans({int page = 1}) async {
    final jsonData = await _getJsonData<Map<String, dynamic>>('talismans', {'page': page.toString()});
    final response = TalismansResponse.fromJson(jsonData);
    talismans = response.data;
    notifyListeners();
  }
}