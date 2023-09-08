import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_list/logic/pokemon_name_checker.dart';
import '../screens/pokemon_details_screen.dart';
import '../screens/pokemon_details_screen_error.dart';

class BuildPokemonSearcher extends StatelessWidget {
  final List<dynamic> allPokemonList;
  final int regionPokemonListLength;
  final _textEditingController = TextEditingController();
  final PokemonNameChecker pokemonChecker = PokemonNameChecker();
  final int initialListPokemonValue;

  BuildPokemonSearcher(context, this.allPokemonList,
      this.regionPokemonListLength, this.initialListPokemonValue,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          width: double.infinity,
          color: Colors.white,
          alignment: Alignment.center,
          child: TextField(
            controller: _textEditingController,
            textAlign: TextAlign.center,
            maxLines: 1,
            maxLength: 15,
            textCapitalization: TextCapitalization.characters,
            showCursor: true,
            keyboardType: TextInputType.streetAddress,
            keyboardAppearance: Brightness.dark,
            inputFormatters: [
              // Limit Available Char to be Typed - Only Letters and the "-" symbol
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z-2]")),
            ],
            style: const TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
                backgroundColor: Color.fromRGBO(255, 255, 255, 0)),
            onTapOutside: (value) {
              // Control Unfocused KeyBoard
              FocusScope.of(context).unfocus();
            },
            onSubmitted: (value) {
              // Control Unfocused KeyBoard
              FocusScope.of(context).unfocus();
              // // Control Clean Text os Textfield
              _textEditingController.clear();
              // LowerCase Value for any Input
              final searchText = value.toLowerCase();
              // Correct pokemon name if necessary and returns pokemon images/gifs URLs
              final pokemonFinalData =
                  pokemonChecker.nameCheckerGetImageURL(searchText);
              // Add total length of Pokemon List (All or Per Region)
              final finalPokemonValue =
                  regionPokemonListLength + initialListPokemonValue - 1;
              // Check if the Name is found on the Pokemon List
              final pokemonChecked = pokemonChecker.pokemonListComparison(
                  allPokemonList,
                  pokemonFinalData[0],
                  (initialListPokemonValue - 1),
                  finalPokemonValue);
              // Bool if pokemon is Found
              final isFound = pokemonChecked[0];
              // Included PokemonID
              final int pokemonId = pokemonChecked[1];
              // Is Found is true - proceed to go to the Details Screen
              if (isFound == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PokemonDetailsScreen(
                      pokemon: pokemonFinalData[0],
                      imageUrl: pokemonFinalData[1],
                      imageUrl2: pokemonFinalData[2],
                      pokemonId: pokemonId,
                    ),
                  ),
                );
              }
              // Is Found is false - proceed to go to the Details Error Screen
              else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PokemonDetailsScreenError(
                      pokemonName: pokemonFinalData[0],
                    ),
                  ),
                );
              }
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                size: 40,
              ),
              hintText: 'Type a Pokemon Name',
            ),
          ),
        ),
      ],
    );
  }
}
