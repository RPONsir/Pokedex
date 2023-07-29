import 'package:flutter/material.dart';
import 'package:pokemon_list/widgets/pokemon_details_info_title.dart';
import 'package:pokemon_list/widgets/build_pokemon_image_gif_name_link.dart';
import '../logic/pokemon_name_checker.dart';

// ignore: must_be_immutable
class PokemonPrevNextImagesWithTitleAndLink extends StatelessWidget{

  final int pokemonId1;
  final List pokemonName1;
  final List pokemonType1;
  final int pokemonId2;
  final List pokemonName2;
  final List pokemonType2;
  late String pokeTitle;

  PokemonPrevNextImagesWithTitleAndLink(this.pokemonId1, this.pokemonName1, this.pokemonType1, this.pokemonId2, this.pokemonName2,this.pokemonType2, this.pokeTitle, {super.key});

  final PokemonNameChecker pokemonChecker = PokemonNameChecker();

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        PokemonDetailsInfoTitle(pokeTitle.toUpperCase()),
        const SizedBox(height: 20,),
        //Display Different Pokemon's
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PokemonGifWithNameLink(pokemonId1, pokemonName1, pokemonType1,),
            const SizedBox(width: 10,),
            PokemonGifWithNameLink(pokemonId2, pokemonName2, pokemonType2,),
          ],
        ),
        const SizedBox(height: 20,),
      ],
    );
  }

}