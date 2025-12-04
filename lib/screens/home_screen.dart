// home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:dragon_ball_provider/models/modelos.dart';
import 'package:dragon_ball_provider/widgets/category_slider.dart';
import 'package:dragon_ball_provider/providers/provider_redux.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onInit: (store) {
        // Carga ambos datos al iniciar
        store.dispatch(fetchCharacters());
        store.dispatch(fetchPlanets());
      },
      converter: (store) => _ViewModel.fromStore(store),
      builder: (context, vm) {
        // Pantalla de carga
        if (vm.isLoading && vm.personajes.isEmpty && vm.planetas.isEmpty) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(color: Colors.amber, strokeWidth: 6),
                  SizedBox(height: 30),
                  Text(
                    "Cargando Dragon Ball...",
                    style: TextStyle(color: Colors.amber, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            title: const Text(
              "DRAGON BALL",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: Text(
                    "¡Bienvenido, guerrero!",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.amber),
                  ),
                ),

                const SizedBox(height: 20),

                // Slider de Personajes
                CategorySlider(
                  title: "Personajes",
                  items: vm.personajes,
                  type: "personaje",
                  onTap: (character) {
                    // Aquí puedes abrir un modal o ir a detalle
                    _showCharacterDialog(context, character as Character);
                  },
                ),

                // Slider de Planetas
                CategorySlider(
                  title: "Planetas",
                  items: vm.planetas,
                  type: "planeta",
                  onTap: (planet) {
                    _showPlanetDialog(context, planet as Planet);
                  },
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        );
      },
    );
  }

  // Modal bonito para personaje
  void _showCharacterDialog(BuildContext context, Character character) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(character.name, style: const TextStyle(color: Colors.amber)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(character.image, height: 200, fit: BoxFit.cover),
            ),
            const SizedBox(height: 15),
            Text("Raza: ${character.race}", style: const TextStyle(color: Colors.white)),
            Text("Ki: ${character.ki}", style: const TextStyle(color: Colors.white70)),
            Text("Afiliación: ${character.affiliation}", style: const TextStyle(color: Colors.white70)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cerrar", style: TextStyle(color: Colors.amber)),
          ),
        ],
      ),
    );
  }

  // Modal bonito para planeta
  void _showPlanetDialog(BuildContext context, Planet planet) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(planet.name, style: const TextStyle(color: Colors.amber)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                planet.image,
                height: 180,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 180,
                  color: Colors.grey[800],
                  child: const Icon(Icons.public, size: 60, color: Colors.white54),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              planet.isDestroyed ? "Destruido" : "Intacto",
              style: TextStyle(color: planet.isDestroyed ? Colors.red : Colors.green),
            ),
            const SizedBox(height: 8),
            Text(planet.description, style: const TextStyle(color: Colors.white70), textAlign: TextAlign.center),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cerrar", style: TextStyle(color: Colors.amber)),
          ),
        ],
      ),
    );
  }
}

// ViewModel para conectar Redux con la UI
class _ViewModel {
  final List<Character> personajes;
  final List<Planet> planetas;
  final bool isLoading;

  _ViewModel({required this.personajes, required this.planetas, required this.isLoading});

  static _ViewModel fromStore(store) {
    return _ViewModel(
      personajes: store.state.personajes,
      planetas: store.state.planetas,
      isLoading: store.state.isLoading,
    );
  }
}