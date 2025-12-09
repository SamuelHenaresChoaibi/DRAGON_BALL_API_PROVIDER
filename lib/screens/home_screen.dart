// home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:dragon_ball_provider/models/modelos.dart';
import 'package:dragon_ball_provider/widgets/widgets.dart';
import 'package:dragon_ball_provider/providers/provider_redux.dart';
import 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      onInit: (store) {
        if (store.state.personajes.isEmpty) store.dispatch(fetchCharacters());
        if (store.state.planetas.isEmpty) store.dispatch(fetchPlanets());
      },
      converter: (store) => ViewModel.fromStore(store),
      builder: (context, vm) {
        // Pantalla de carga estilo DBZ
        if (vm.isLoading && vm.personajes.isEmpty && vm.planetas.isEmpty) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF0D1B2A), Color(0xFF1B263B), Color(0xFF415A77)],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/dragon_ball_logo.png', height: 120), // opcional: pon el logo
                    const SizedBox(height: 40),
                    const CircularProgressIndicator(
                      color: Colors.orange,
                      strokeWidth: 8,
                      backgroundColor: Colors.orangeAccent,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Cargando el Universo 7...",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        shadows: [Shadow(color: Colors.orangeAccent, blurRadius: 20)],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              "DRAGON BALL",
              style: TextStyle(
                fontFamily: 'Anime', // Usa una fuente tipo DBZ (descárgala y ponla en pubspec)
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                letterSpacing: 4,
                shadows: [Shadow(color: Colors.orangeAccent, blurRadius: 10)],
              ),
            ),
            centerTitle: true,
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0A1B3D),
                  Color(0xFF112B5C),
                  Color(0xFF1E4D92),
                  Color(0xFF0F3460),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Título épico
                  const Text(
                    "¡KAMEHAMEHAAA!",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                      letterSpacing: 3,
                      shadows: [
                        Shadow(color: Colors.orangeAccent, blurRadius: 20),
                        Shadow(color: Colors.black, blurRadius: 5),
                      ],
                    ),
                  ),
                  const Text(
                    "Elige tu destino, guerrero",
                    style: TextStyle(color: Colors.white70, fontSize: 18, letterSpacing: 1.5),
                  ),

                  const SizedBox(height: 40),

                  // BOTONES DRAGON BALL Z
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        // PERSONAJES
                        Expanded(
                          child: DBZButton(
                            title: "GUERREROS",
                            isSelected: vm.currentCategory == 'personajes',
                            onTap: () => vm.changeCategory('personajes'),
                            colors: const [Color(0xFFFF8C00), Color(0xFFFFA500), Color(0xFFFFC107)],
                            icon: Icons.whatshot,
                          ),
                        ),
                        const SizedBox(width: 20),
                        // PLANETAS
                        Expanded(
                          child: DBZButton(
                            title: "PLANETAS",
                            isSelected: vm.currentCategory == 'planetas',
                            onTap: () => vm.changeCategory('planetas'),
                            colors: const [Color(0xFF00CED1), Color(0xFF40E0D0), Color(0xFF48D1CC)],
                            icon: Icons.public,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // UN SOLO SLIDER con efecto de aura
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: vm.currentCategory == 'personajes'
                                ? Colors.orange.withOpacity(0.6)
                                : Colors.cyan.withOpacity(0.6),
                            blurRadius: 30,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 600),
                          transitionBuilder: (child, animation) {
                            return FadeTransition(opacity: animation, child: child);
                          },
                          child: CategorySlider(
                            key: ValueKey(vm.currentCategory),
                            title: vm.currentCategory == 'personajes' ? "GUERREROS Z" : "PLANETAS DEL UNIVERSO",
                            items: vm.currentCategory == 'personajes' ? vm.personajes : vm.planetas,
                            type: vm.currentCategory,
                            onTap: (item) {
                              if (vm.currentCategory == 'personajes') {
                                _showCharacterDialog(context, item as Character);
                              } else {
                                _showPlanetDialog(context, item as Planet);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // DIÁLOGOS DRAGON BALL Z
  void _showCharacterDialog(BuildContext context, Character character) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF0F1B3A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          character.name.toUpperCase(),
          style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 24),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange, width: 3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(character.image, height: 240, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 20),
            _infoRow("Raza", character.race, Icons.accessibility_new),
            _infoRow("Ki", character.ki, Icons.flash_on),
            _infoRow("Afiliación", character.affiliation, Icons.group),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("¡KAIO-KEN!", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showPlanetDialog(BuildContext context, Planet planet) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF0F1B3A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          planet.name.toUpperCase(),
          style: const TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold, fontSize: 24),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.cyan, width: 3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  planet.image,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.public, size: 100, color: Colors.cyan),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              planet.isDestroyed ? "DESTRUIDO" : "INTACTO",
              style: TextStyle(
                color: planet.isDestroyed ? Colors.red : Colors.green,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                planet.description,
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("¡GENKI DAMA!", style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange, size: 20),
          const SizedBox(width: 10),
          Text("$label: ", style: const TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, style: const TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}