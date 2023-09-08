import 'package:flutter/material.dart';
import 'package:pokemon_list/widgets/pokemon_box_image.dart';
import '../logic/pokemon_name_checker.dart';
import '../screens/pokemon_details_screen.dart';

class BuildPokemonGrid extends StatelessWidget {
  final List<dynamic> pokemonList;
  final int addValueList;

  final PokemonNameChecker pokemonChecker = PokemonNameChecker();

  BuildPokemonGrid(this.pokemonList, this.addValueList, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 200,
            childAspectRatio: 1,
            crossAxisSpacing: 5,
            mainAxisSpacing: 10),
        itemCount: pokemonList.length,
        itemBuilder: (context, index) {
          // Obtain Pokemon Data
          final pokemon = pokemonList[index];
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
        });
  }
}
