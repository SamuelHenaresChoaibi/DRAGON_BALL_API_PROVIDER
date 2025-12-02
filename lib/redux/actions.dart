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
class FetchCharacters {
  const FetchCharacters();
}

class FetchPlanets {
  const FetchPlanets();
}

// Acción para seleccionar un elemento (personaje o planeta)
class SelectItem {
  final String id;
  final String type; // 'personaje' o 'planeta'

  const SelectItem({
    required this.id,
    required this.type,
  });
}

// Acciones de estado de carga (opcionales)
class CharactersLoading {}
class PlanetsLoading {}
class DataLoaded {}
