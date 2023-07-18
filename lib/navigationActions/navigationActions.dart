import 'package:flutter/material.dart';
import 'package:pokemon_list/screens/pokemon_details_screen.dart';
import 'package:pokemon_list/screens/pokemon_details_screen_error.dart';

class NavigateTo{
  void PokemonDetails(context, dynamic pokemon, dynamic imageUrl, dynamic imageUrl2) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PokemonDetailsScreen(pokemon: pokemon, imageUrl : imageUrl, imageUrl2: imageUrl2,),
      ),
    );
  }

  void PokemonDetailsError(context, dynamic pokemonName, ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PokemonDetailsScreenError(pokemonName: pokemonName,),
      ),
    );
  }
}