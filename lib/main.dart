import 'package:flutter/material.dart';
import 'screens/pokemon_list_screen.dart';

void main() {
  runApp(const PokemonApp());
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Pokemon App',
        home: PokemonListScreen(),
    );
  }
}


