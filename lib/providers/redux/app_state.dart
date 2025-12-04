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
// app_state.dart
import 'package:flutter/foundation.dart';
import 'package:dragon_ball_provider/models/modelos.dart';


@immutable
class AppState {
  final List<Character> personajes;
  final List<Planet> planetas;
  final bool isLoading;
  final int? selectedId;
  final String? selectedType;

  const AppState({
    this.personajes = const [],
    this.planetas = const [],
    this.isLoading = false,
    this.selectedId,
    this.selectedType,
  });

  AppState copyWith({
    List<Character>? personajes,
    List<Planet>? planetas,
    bool? isLoading,
    int? selectedId,
    String? selectedType,
  }) {
    return AppState(
      personajes: personajes ?? this.personajes,
      planetas: planetas ?? this.planetas,
      isLoading: isLoading ?? this.isLoading,
      selectedId: selectedId ?? this.selectedId,
      selectedType: selectedType ?? this.selectedType,
    );
  }
}