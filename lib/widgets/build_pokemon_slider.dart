import 'package:flutter/material.dart';
import 'package:pokemon_list/logic/pokemon_name_checker.dart';
import 'package:pokemon_list/widgets/pokemon_box_image.dart';
import 'package:pokemon_list/widgets/pokemon_sliders_title_redirect_regionlist.dart';
import '../screens/pokemon_details_screen.dart';

class BuildPokemonSlider extends StatelessWidget {
  final String sliderTitle;
  final List<dynamic> allPokemonList;
  final List<dynamic> regionalPokemonList;
  final int addValueList;

  final PokemonNameChecker pokemonChecker = PokemonNameChecker();

  BuildPokemonSlider(this.sliderTitle, this.allPokemonList,
      this.regionalPokemonList, this.addValueList,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SeparatingTitleSpaceSliders(
            allPokemonList, regionalPokemonList, sliderTitle, addValueList),
        Container(
          color: Colors.black,
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: regionalPokemonList.length,
            itemBuilder: (context, index) {
              // Obtain Pokemon Data
              final pokemon = regionalPokemonList[index];
              // Obtain Pokemon ID
              final pokemonId = index + addValueList;
              // Obtain pokemon Name
              final pokemonName = pokemon['name'].toString();
              // Correct pokemon name if necessary and returns pokemon images/gifs URLs
              final pokemonFinalData =
                  pokemonChecker.nameCheckerGetImageURL(pokemonName);

              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PokemonDetailsScreen(
                      pokemon: pokemonFinalData[0],
                      imageUrl: pokemonFinalData[1],
                      imageUrl2: pokemonFinalData[2],
                      pokemonId: pokemonId,
                    ),
                  ),
                ),
                child: PokemonBoxImage(pokemonFinalData[0], pokemonFinalData[1],
                    pokemonFinalData[2], pokemonId),
              );
            },
          ),
        ),
      ],
    );
  }
}
