import 'package:flutter/material.dart';
import 'package:pokemon_list/widgets/pokemon_front_back_display_box_with_background.dart';
import '../logic/pokemon_name_checker.dart';

// ignore: must_be_immutable
class PokemonEvolutionChainImages extends StatelessWidget{

  final int pokemonId1;
  final List pokemonName1;
  final List pokemonType1;
  final int pokemonId2;
  final List pokemonName2;
  final List pokemonType2;
  late String pokeTitle;

  PokemonEvolutionChainImages(this.pokemonId1, this.pokemonName1, this.pokemonType1, this.pokemonId2, this.pokemonName2,this.pokemonType2, this.pokeTitle, {super.key});

  final PokemonNameChecker pokemonChecker = PokemonNameChecker();

  @override
  Widget build(BuildContext context){
    bool imageFrontDisplayed = true;
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5),
          width: 300,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10),),
            color: Colors.grey,
          ),
          child: Text(pokeTitle,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        const SizedBox(height: 20,),
        //Display Different Pokemon's (to be enhanced)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PokemonGifVisualWithBackground(
              imageFrontDisplayed: imageFrontDisplayed,
              types: pokemonType1, imageUrl: pokemonName1[1].toString(),
              imageUrl2: pokemonName1[2].toString(),
              boxWidth: 160,
              boxHeight: 110,
            ),
            const SizedBox(width: 30,),
            PokemonGifVisualWithBackground(
              imageFrontDisplayed: imageFrontDisplayed,
              types: pokemonType2, imageUrl: pokemonName2[1].toString(),
              imageUrl2: pokemonName2[2].toString(),
              boxWidth: 160,
              boxHeight: 110,
            ),
          ],
        ),
      ],
    );
  }

}