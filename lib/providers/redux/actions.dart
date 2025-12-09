/*
Las acciones son puras clases simples que Redux "escucha" en los reducers. 
No tienen lógica, solo dicen "qué pasó". Los reducers deciden "qué hacer" con ellas.

Qué hace cada acción:
- FetchCharacters(): Carga la lista de personajes del API
- FetchPlanets(): Carga la lista de planetas del API
- SelectItem(id: 'goku', type: 'character'): mostraría los detalles de Goku
- CharactersLoading(): cargando personajes (muestra el spinner)

Uso en la app:
- En home_screen.dart (al iniciar):
    store.dispatch(FetchCharacters());
    store.dispatch(FetchPlanets());

- Al tocar un personaje:
    store.dispatch(SelectItem(id: 'goku', type: 'character'));
*/

// Acciones para cargar datos del API
// actions.dart
// redux/actions.dart
import 'package:dragon_ball_provider/models/modelos.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:redux/redux.dart';
import 'app_state.dart';

// ========== ACCIONES SÍNCRONAS ==========
class PersonajesCargados {
  final List<Character> personajes;
  PersonajesCargados(this.personajes);
}

class PlanetasCargados {
  final List<Planet> planetas;
  PlanetasCargados(this.planetas);
}

class SetLoading {
  final bool isLoading;
  SetLoading(this.isLoading);
}

class ChangeCategoryAction {
  final String category; // 'personajes' o 'planetas'
  ChangeCategoryAction(this.category);
}

// ========== ACCIONES ASÍNCRONAS ==========
ThunkAction<AppState> fetchCharacters() {
  return (Store<AppState> store) async {
    store.dispatch(SetLoading(true));
    try {
      final response = await http.get(
        Uri.parse('https://dragonball-api.com/api/characters?limit=50'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<Character> chars = (data['items'] as List)
            .map((e) => Character.fromJson(e))
            .toList();
        store.dispatch(PersonajesCargados(chars));
      }
    } catch (e) {
      print("Error cargando personajes: $e");
    } finally {
      store.dispatch(SetLoading(false));
    }
  };
}

ThunkAction<AppState> fetchPlanets() {
  return (Store<AppState> store) async {
    store.dispatch(SetLoading(true));
    try {
      final response = await http.get(
        Uri.parse('https://dragonball-api.com/api/planets?limit=50'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<Planet> planets = (data['items'] as List)
            .map((e) => Planet.fromJson(e))
            .toList();
        store.dispatch(PlanetasCargados(planets));
      }
    } catch (e) {
      print("Error cargando planetas: $e");
    } finally {
      store.dispatch(SetLoading(false));
    }
  };
}