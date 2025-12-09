import 'package:dragon_ball_provider/models/modelos.dart';
import 'package:dragon_ball_provider/providers/provider_redux.dart';
import 'package:redux/redux.dart';

class ViewModel {
  final List<Character> personajes;
  final List<Planet> planetas;
  final bool isLoading;
  final String currentCategory;
  final Function(String) changeCategory;

  ViewModel({
    required this.personajes,
    required this.planetas,
    required this.isLoading,
    required this.currentCategory,
    required this.changeCategory,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return ViewModel(
      personajes: store.state.personajes,
      planetas: store.state.planetas,
      isLoading: store.state.isLoading,
      currentCategory: store.state.currentCategory,
      changeCategory: (cat) => store.dispatch(ChangeCategoryAction(cat)),
    );
  }
}