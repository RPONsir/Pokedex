import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_list/logic/pokemon_name_checker.dart';
import '../screens/pokemon_details_screen.dart';
import '../screens/pokemon_details_screen_error.dart';

class BuildPokemonSearcher extends StatelessWidget{

  final List<dynamic> regionPokemonList;
  final _textEditingController = TextEditingController();
  final PokemonNameChecker pokemonChecker = PokemonNameChecker();

  BuildPokemonSearcher(context, this.regionPokemonList , {super.key});
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Container(
          height: 80,
          width: double.infinity,
          color: Colors.white,
          alignment: Alignment.center,
          child:
          TextField(
            controller: _textEditingController,
            textAlign: TextAlign.center,
            maxLines: 1,
            maxLength: 15,
            textCapitalization: TextCapitalization.characters,
            showCursor: true,
            keyboardType: TextInputType.streetAddress,
            keyboardAppearance: Brightness.dark,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z-]")),
            ],
            style: const TextStyle(color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
                backgroundColor: Color.fromRGBO(255, 255, 255, 0)),
            onSubmitted: (value) {
              // Deseleccionar Keyboard
              FocusScope.of(context).unfocus();
              // Limpiar Text Textfield
              _textEditingController.clear();
              // Convertir Value a lowercase para hacer match con Listado Pokemons
              final searchText = value.toLowerCase();
              // Conversor de Nombres y obtencion de imagenes de Pokemons
              final pokemonFinalData = pokemonChecker.lineChecker(searchText);
              // Nombre en String
              final pokemonFinalName = pokemonFinalData[0];
              // URL Gif
              final imageUrl = pokemonFinalData[1];
              // URL Gif 2
              final imageUrl2 = pokemonFinalData[2];
              // Comparacion de Nombre con Lista de Pokemon
              final isFound = pokemonChecker.pokemonListComparison(regionPokemonList, pokemonFinalName);
              if(isFound==true){
                // Coincide va a llevar al Pokemon Details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PokemonDetailsScreen(pokemon: pokemonFinalName, imageUrl : imageUrl, imageUrl2: imageUrl2,),
                  ),
                );
              }
              else{
                // NO Coincide va a llevar al Pokemon Details Error
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PokemonDetailsScreenError(pokemonName: pokemonFinalName,),
                  ),
                );
              }
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search, size: 40,),
              hintText: 'Type a Pokemon Name',
            ),
          ),
        ),
      ],
    );
  }
}