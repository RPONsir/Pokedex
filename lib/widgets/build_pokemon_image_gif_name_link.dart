import 'package:flutter/material.dart';
import 'package:pokemon_list/widgets/pokemon_front_back_display_box_with_background.dart';
import '../screens/pokemon_details_screen.dart';

class PokemonGifWithNameLink extends StatelessWidget{

  final int pokemonId;
  final List pokemonName;
  final List pokemonType;

  const PokemonGifWithNameLink(this.pokemonId, this.pokemonName, this.pokemonType, {super.key});

  final imageFrontDisplayed = true;

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        PokemonGifVisualWithBackground(
          imageFrontDisplayed: imageFrontDisplayed,
          types: pokemonType, imageUrl: pokemonName[1].toString(),
          imageUrl2: pokemonName[2].toString(),
          boxWidth: 150,
          boxHeight: 100,
          edgeSpacing: 0,
        ),
        const SizedBox(height: 20,),
        GestureDetector(
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PokemonDetailsScreen(
                    pokemon: pokemonName[0],
                    imageUrl: pokemonName[1],
                    imageUrl2: pokemonName[2],
                    pokemonId: pokemonId,
                  ),
            ),
          ),
          child: Text('#$pokemonId : ${pokemonName[0].toString().toUpperCase()}',
            style: const TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

}