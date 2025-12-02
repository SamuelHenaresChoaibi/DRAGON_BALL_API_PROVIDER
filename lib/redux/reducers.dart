/*
Qué hace cada reducer:
_fetchCharacters: Recibe la acción → actualiza state.characters con datos del API
_fetchPlanets: Recibe la acción → actualiza state.planets
_selectItem: Recibe la acción → actualiza state.selectedId con el elemento clickeado
_loading: Muestran estados de carga (opcional)

Flujo completo:

1. dispatch(FetchCharacters()) 
2. _fetchCharacters recibe acción 
3. Retorna NUEVO AppState con characters actualizados 
4. Store guarda el nuevo estado 
5. Carruseles se repintan automáticamente

IMPORTANTE: Los reducers SIEMPRE retornan un NUEVO estado (usando copyWith), NUNCA mutan el estado actual. 
Esto mantiene todo predecible y debuggeable.
*/

import 'package:redux/redux.dart';
import 'app_state.dart';
import 'actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return combineReducers<AppState>([
    TypedReducer<AppState, FetchCharacters>(_fetchCharacters).call,
    TypedReducer<AppState, FetchPlanets>(_fetchPlanets).call,
    TypedReducer<AppState, SelectItem>(_selectItem).call,
    TypedReducer<AppState, CharactersLoading>(_charactersLoading).call,
    TypedReducer<AppState, PlanetsLoading>(_planetsLoading).call,
  ])(state, action);
}

AppState _fetchCharacters(AppState state, FetchCharacters action) {
  // Aquí normalmente llamarías al API y retornarías datos
  // Por ahora simulamos con datos vacíos
  return state.copyWith(personajes: []);
}

AppState _fetchPlanets(AppState state, FetchPlanets action) {
  // Simulamos carga de planetas
  return state.copyWith(planetas: []);
}

AppState _selectItem(AppState state, SelectItem action) {
  return state.copyWith(selectedId: '${action.type}_${action.id}');
}

AppState _charactersLoading(AppState state, CharactersLoading action) {
  return state.copyWith(personajes: []); // Podrías agregar loading state
}

AppState _planetsLoading(AppState state, PlanetsLoading action) {
  return state.copyWith(planetas: []);
}
