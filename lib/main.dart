import 'package:flutter/material.dart';
import 'package:elden_ring_app/providers/elden_ring_providers.dart';
import 'package:elden_ring_app/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

//Widget raíz que configura los providers de la app
class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Crea y provee el EldenRingProvider en toda la app
        ChangeNotifierProvider(create: (_) => EldenRingProvider(), lazy: false),
      ],
      child: MyApp(),
    );
  }
}

//Aplicación principal de la Wiki de Elden Ring
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Elden Ring Wiki',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomeScreen(), //Pantalla principal con los sliders
        'details': (BuildContext context) => EldenDetailsScreen(), //Pantalla de detalle de cualquier objeto
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.indigo),
      ),
    );
  }
}