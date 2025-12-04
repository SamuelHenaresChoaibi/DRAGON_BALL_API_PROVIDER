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
// reducers.dart
import 'package:redux/redux.dart';
import 'app_state.dart';
import 'actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return combineReducers<AppState>([
    TypedReducer<AppState, PersonajesCargados>(_personajesCargados),
    TypedReducer<AppState, PlanetasCargados>(_planetasCargados),
    TypedReducer<AppState, SetLoading>(_setLoading),
    TypedReducer<AppState, SelectItem>(_selectItem),
  ])(state, action);
}

AppState _personajesCargados(AppState state, PersonajesCargados action) {
  return state.copyWith(personajes: action.personajes);
}

AppState _planetasCargados(AppState state, PlanetasCargados action) {
  return state.copyWith(planetas: action.planetas);
}

AppState _setLoading(AppState state, SetLoading action) {
  return state.copyWith(isLoading: action.isLoading);
}

AppState _selectItem(AppState state, SelectItem action) {
  return state.copyWith(
    selectedId: action.id,
    selectedType: action.type,
  );
}