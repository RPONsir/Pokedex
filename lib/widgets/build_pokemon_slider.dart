import 'package:flutter/material.dart';
import 'package:pokemon_list/logic/pokemon_name_checker.dart';
import 'package:pokemon_list/navigationActions/navigationActions.dart';
import 'package:pokemon_list/widgets/pokemon_gif.dart';
import 'package:pokemon_list/widgets/pokemon_id_text.dart';
import 'package:pokemon_list/widgets/pokemon_name_text.dart';
import 'package:pokemon_list/widgets/separate_sliders.dart';

class BuildPokemonSlider extends StatelessWidget{

  final String sliderTitle;
  final List<dynamic> pokemonList;
  final int addValueList;

  final PokemonNameChecker pokemonChecker = PokemonNameChecker();
  final NavigateTo navigateTo = NavigateTo();

  BuildPokemonSlider(this.sliderTitle , this.pokemonList, this.addValueList, {super.key});
  @override

  Widget build(BuildContext context){
    return Column(
      // Separador con nombre de Region
      children: [
        SeparatingSpaceSliders(sliderTitle),
        // Generaxion recuadros con Imagen y Nombre del Slider
        Container(
          color: Colors.black,
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: pokemonList.length,
            itemBuilder: (context, index) {
              // Del API se pokemon que proviene con 2 valores
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
              // URL de GIFS
              //'https://www.pkparaiso.com/imagenes/xy/sprites/animados/$pokemonFinalName.gif';
              // final String imageUrl2 = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados-espalda/${pokemonFinalName[0]}.gif';
              return GestureDetector(
                // Al hacer click navegara al Pokemon Details
                onTap: () => navigateTo.PokemonDetails(context, pokemonFinalName, imageUrl, imageUrl2),
                child: Container(
                  width: 150,
                  // Espacio entre Containers de manera vertical
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      // Agregamos Asset para que carge de una sin problemas
                      Image.asset(
                        'images/listBackground.jpeg',
                        width: 150,
                        fit: BoxFit.fitWidth,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PokemonIdText(pokemonId, 18),
                          const SizedBox(height: 8),
                          // Generacion animacion - mientras cargan GIFS
                          PokemonGif(imageUrl, imageUrl2, 150, 110, true),
                          // Espacio entre GIF y Nombre del Pokemon
                          const SizedBox(height: 3),
                          PokemonNameText(pokemonFinalName, 18),
                          const SizedBox(height: 6),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}