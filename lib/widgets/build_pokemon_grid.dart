import 'package:flutter/material.dart';
import 'package:pokemon_list/widgets/pokemon_box_image.dart';
import '../logic/pokemon_name_checker.dart';
import '../screens/pokemon_details_screen.dart';

class BuildPokemonGrid extends StatelessWidget{
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
        gridDelegate:
        const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 205,
            childAspectRatio: 1,
            crossAxisSpacing: 5,
            mainAxisSpacing: 10),
          itemCount: pokemonList.length,
          itemBuilder: (context, index) {
          final pokemon = pokemonList[index];
          // ID de POKEMON
          final pokemonId = index+addValueList;
          // Obtenemos el Nombre
          final pokemonName = pokemon['name'].toString();
          // Validamos el Nombre que este bien escrito y se edita de ser necesario
          final pokemonFinalData = pokemonChecker.lineChecker(pokemonName);
          // Obtenemos nombre final del pokemon
          final pokemonFinalName = pokemonFinalData[0];
          // Obtenemos URL del GIF
          final imageUrl = pokemonFinalData[1];
          // Obtenemos URL del Segundo GIF
          final imageUrl2 = pokemonFinalData[2];
          return GestureDetector(
              // Al hacer click navegara al Pokemon Details
              onTap: () =>
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PokemonDetailsScreen(pokemon: pokemonFinalName,
                        imageUrl: imageUrl,
                        imageUrl2: imageUrl2,
                        pokemonId: pokemonId,
                      ),
                ),
              ),
            child: PokemonBoxImage(pokemonFinalName, imageUrl, imageUrl2, pokemonId),
          );
        }
    );
  }
}