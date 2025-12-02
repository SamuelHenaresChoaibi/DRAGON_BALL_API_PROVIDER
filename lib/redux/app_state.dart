/*
Este AppState es inmutable y contiene:
- characters: Lista de personajes cargados
- planets: Lista de planetas cargados
- selectedId: El id del personaje o planeta que se ha seleccionado para ver detalles (o null si no hay selección)

El método copyWith permite crear nuevas copias del estado con cambios puntuales, lo que es fundamental para que Redux 
maneje el estado sin mutaciones directas.

Este es el “cuaderno central” donde Redux guardará y actualizará toda la información de la app. 
Desde aquí, los reducers cambiarán el estado y las pantallas leerán para mostrar la información correcta.
*/

import 'package:flutter/foundation.dart';
import '../models/personaje.dart';
import '../models/planeta.dart';

@immutable
class AppState {
  final List<Personaje> personajes;
  final List<Planeta> planetas;
  final String? selectedId; // id del personaje o planeta seleccionado, o null

  const AppState({
    this.personajes = const [],
    this.planetas = const [],
    this.selectedId,
  });

  AppState copyWith({
    List<Personaje>? personajes,
    List<Planeta>? planetas,
    String? selectedId,
  }) {
    return AppState(
      personajes: personajes ?? this.personajes,
      planetas: planetas ?? this.planetas,
      selectedId: selectedId ?? this.selectedId,
    );
  }
}
