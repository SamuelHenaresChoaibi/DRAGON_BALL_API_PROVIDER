import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'screens/home_screen.dart';         
import 'providers/provider_redux.dart'; 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store, 
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dragon Ball Wiki',
        home: const HomeScreen(),
        
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.amber,
          scaffoldBackgroundColor: Colors.grey[900],
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.amber,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}