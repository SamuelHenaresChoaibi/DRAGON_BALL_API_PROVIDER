import 'package:flutter/material.dart';
import 'package:elden_ring_app/providers/elden_ring_providers.dart';
import 'package:elden_ring_app/widgets/category_slider.dart';
import 'package:provider/provider.dart';

//Pantalla principal de la app (Home)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Accede al provider que contiene todos los datos de Elden Ring
    final eldenProvider = Provider.of<EldenRingProvider>(context);

    //Si aún se están cargando los datos --> muestra pantalla de carga
    if (eldenProvider.isLoading == true) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.amber,
                strokeWidth: 6,
              ),
              SizedBox(height: 30),
              Text(
                "Despertando el Círculo de Elden...",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    //Pantalla principal cuando ya hay datos
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "Elden Ring Wiki",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text(
                "¡Bienvenido, Sinluz!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ),

            SizedBox(height: 10),

            //Slider horizontal de armas
            CategorySlider(
              title: "Armas Legendarias",
              items: eldenProvider.weapons,
              type: 'weapon',
              onTap: (weapon) {
                Navigator.pushNamed(
                  context,
                  'details',
                  arguments: {'item': weapon, 'type': 'weapon'},
                );
              },
            ),

            //Slider horizontal de armaduras
            CategorySlider(
              title: "Armaduras Épicas",
              items: eldenProvider.armors,
              type: 'armor',
              onTap: (armor) {
                Navigator.pushNamed(
                  context,
                  'details',
                  arguments: {'item': armor, 'type': 'armor'},
                );
              },
            ),

            //Slider horizontal de hechizos
            CategorySlider(
              title: "Hechizos del Poder",
              items: eldenProvider.sorceries,
              type: 'sorcery',
              onTap: (spell) {
                Navigator.pushNamed(
                  context,
                  'details',
                  arguments: {'item': spell, 'type': 'sorcery'},
                );
              },
            ),

            //Slider horizontal de espíritus
            CategorySlider(
              title: "Cenizas de Espíritus",
              items: eldenProvider.spirits,
              type: 'spirit',
              onTap: (spirit) {
                Navigator.pushNamed(context, 'details', arguments: {
                  'item': spirit,
                  'type': 'spirit'
                });
              },
            ),

            //Slider horizontal de talismanes
            CategorySlider(
              title: "Talismanes Sagrados",
              items: eldenProvider.talismans,
              type: 'talisman',
              onTap: (talisman) {
                Navigator.pushNamed(context, 'details', arguments: {
                  'item': talisman,
                  'type': 'talisman'
                });
              },
            ),

            //Espacio final para que no quede pegado al fondo
            SizedBox(height: 50),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}