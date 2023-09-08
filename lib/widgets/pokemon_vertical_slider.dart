import 'package:flutter/material.dart';
import 'package:pokemon_list/widgets/pokemon_gif.dart';

import '../logic/pokemon_name_checker.dart';

class PokemonVerticalSlider extends StatelessWidget {
  final List pokemonList;
  final int listIndex;

  PokemonVerticalSlider(this.pokemonList, this.listIndex, {super.key});

  final PokemonNameChecker pokemonChecker = PokemonNameChecker();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListView.builder(
        addRepaintBoundaries: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        itemCount: pokemonList[listIndex].length,
        itemBuilder: (context, index) {
          final secondEvolution = (pokemonList[listIndex]);
          final pokemonFinalData = pokemonChecker
              .nameCheckerGetImageURL(secondEvolution[index].toString());
          return Container(
            width: 180,
            height: 180,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(70),
            ),
            child: PokemonGif(
                pokemonFinalData[1], pokemonFinalData[2], 150, 120, true, 0.9),
          );
        },
      ),
    );
  }
}
