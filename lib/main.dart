import 'package:flutter/material.dart';
import 'package:pokemon_list/pokemonListScreen.dart';

void main() {
  runApp(PokemonApp());
}

class PokemonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pokemon App',
        home: PokemonListScreen(),
    );
  }
}


