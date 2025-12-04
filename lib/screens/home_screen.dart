import 'package:flutter/material.dart';
import 'package:dragon_ball_api_provider/providers/DBprovider.dart';
import 'package:dragon_ball_api_provider/widgets/category_slider.dart';
import 'package:provider/provider.dart';

import '../widgets/category_slider.dart';

//Pantalla principal de la app (Home)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Accede al provider que contiene todos los datos de la API de Dragon Ball
    final DBProvider = Provider.of<DBProvider>(context);

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
                "DRAGON BALL loading...",
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
          "DRAGON BALL",
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
                "¡Bienvenido/a!",
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
              title: "Personajes",
              items: DBProvider.personajes,
              type: 'personaje',
              onTap: (muestra_detalles_personaje) {
                Navigator.pushNamed(
                  context,
                  'detalless',
                  arguments: {'item': personaje, 'type': 'personaje'},
                );
              },
            ),

            //Slider horizontal de armaduras
            CategorySlider(
              title: "Planetas",
              items: DBProvider.planetas,
              type: 'planeta',
              onTap: (muestra_detalles_planeta) {
                Navigator.pushNamed(
                  context,
                  'detalles',
                  arguments: {'item': planeta, 'type': 'planeta'},
                );
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