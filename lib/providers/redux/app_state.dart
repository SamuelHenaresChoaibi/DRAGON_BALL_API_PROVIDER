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
 // redux/app_state.dart
import 'package:flutter/foundation.dart';
import 'package:dragon_ball_provider/models/modelos.dart';

@immutable
class AppState {
  final List<Character> personajes;
  final List<Planet> planetas;
  final bool isLoading;
  final String currentCategory; // 'personajes' o 'planetas' ← NUEVO

  const AppState({
    this.personajes = const [],
    this.planetas = const [],
    this.isLoading = true,
    this.currentCategory = 'personajes', // valor por defecto
  });

  AppState copyWith({
    List<Character>? personajes,
    List<Planet>? planetas,
    bool? isLoading,
    String? currentCategory,
  }) {
    return AppState(
      personajes: personajes ?? this.personajes,
      planetas: planetas ?? this.planetas,
      isLoading: isLoading ?? this.isLoading,
      currentCategory: currentCategory ?? this.currentCategory,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          personajes == other.personajes &&
          planetas == other.planetas &&
          isLoading == other.isLoading &&
          currentCategory == other.currentCategory;

  @override
  int get hashCode =>
      personajes.hashCode ^ planetas.hashCode ^ isLoading.hashCode ^ currentCategory.hashCode;
}