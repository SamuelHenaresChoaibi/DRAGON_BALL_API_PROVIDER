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
