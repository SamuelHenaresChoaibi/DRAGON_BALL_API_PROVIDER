import 'package:redux/redux.dart';
import 'app_state.dart';
import 'actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return combineReducers<AppState>([
    TypedReducer<AppState, PersonajesCargados>(_cargarPersonajes),
    TypedReducer<AppState, PlanetasCargados>(_cargarPlanetas),
    TypedReducer<AppState, SetLoading>(_setLoading),
    TypedReducer<AppState, ChangeCategoryAction>(_cambiarCategoria), // ← NUEVO
  ])(state, action);
}

AppState _cargarPersonajes(AppState state, PersonajesCargados action) {
  return state.copyWith(personajes: action.personajes);
}

AppState _cargarPlanetas(AppState state, PlanetasCargados action) {
  return state.copyWith(planetas: action.planetas);
}

AppState _setLoading(AppState state, SetLoading action) {
  return state.copyWith(isLoading: action.isLoading);
}

AppState _cambiarCategoria(AppState state, ChangeCategoryAction action) {
  return state.copyWith(currentCategory: action.category);
}