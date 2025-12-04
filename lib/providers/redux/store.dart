/*
El Store importa las definiciones del estado (AppState) y el reducer principal (appReducer).
Crea el store Redux con el appReducer para manejar las acciones y un estado inicial vacío.
Aquí el middleware está vacío, pero puedes añadir middleware para peticiones asíncronas (por ejemplo thunk) o logging.
El store es el corazón de Redux: almacena el estado global y recibe las acciones para actualizarlo mediante el reducer, desde donde luego las pantallas obtendrán el estado actualizado para mostrar la UI.
Este store.dart se importa en main.dart para envolver la app con StoreProvider(store: store, child: MyApp()) y hacer que toda la app pueda acceder al estado Redux.
*/

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'app_state.dart';
import 'reducers.dart';

final store = Store<AppState>(
  appReducer,
  initialState: const AppState(),
  middleware: [thunkMiddleware],
);