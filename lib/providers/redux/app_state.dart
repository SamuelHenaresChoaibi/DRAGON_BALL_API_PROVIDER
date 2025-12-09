import 'package:flutter/foundation.dart';
import 'package:dragon_ball_provider/models/modelos.dart';

@immutable
class AppState {
  final List<Character> personajes;
  final List<Planet> planetas;
  final bool isLoading;
  final String currentCategory;

  const AppState({
    this.personajes = const [],
    this.planetas = const [],
    this.isLoading = true,
    this.currentCategory = 'personajes',
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