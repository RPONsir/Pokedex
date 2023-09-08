import 'package:flutter/material.dart';
import 'package:pokemon_list/widgets/pokemon_box_image.dart';
import '../logic/pokemon_name_checker.dart';
import '../screens/pokemon_details_screen.dart';

class BuildPokemonFavoriteGrid extends StatelessWidget{

  final List<dynamic> pokemonFavoriteList;

  final PokemonNameChecker pokemonChecker = PokemonNameChecker();

  BuildPokemonFavoriteGrid(this.pokemonFavoriteList, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 200,
            childAspectRatio: 1,
            crossAxisSpacing: 5,
            mainAxisSpacing: 10),
        itemCount: pokemonFavoriteList.length,
        itemBuilder: (context, index) {
          // Obtain Pokemon Data
          final pokemon = pokemonFavoriteList[index];
          print(pokemon);
          // Obtain Pokemon ID
          final pokemonId = pokemon['pokemonId'];
          // Obtain pokemon Name
          final pokemonName = pokemon['pokemonName'].toString();
          // Correct pokemon name if necessary and returns pokemon images/gifs URLs
          final pokemonFinalData = pokemonChecker.nameCheckerGetImageURL(pokemonName);

          return GestureDetector(
            onTap: () =>
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PokemonDetailsScreen(
                          pokemon: pokemonFinalData[0],
                          imageUrl: pokemonFinalData[1],
                          imageUrl2: pokemonFinalData[2],
                          pokemonId: pokemonId,
                        ),
                  ),
                ),
            child: PokemonBoxImage(pokemonFinalData[0], pokemonFinalData[1], pokemonFinalData[2], pokemonId),
          );
        }
    );
  }
}