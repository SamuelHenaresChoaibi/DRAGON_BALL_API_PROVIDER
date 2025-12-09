import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'app_state.dart';
import 'reducers.dart';

final store = Store<AppState>(
  appReducer,
  initialState: const AppState(),
  middleware: [thunkMiddleware],
);