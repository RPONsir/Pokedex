import 'package:flutter/material.dart';
import 'package:pokemon_list/logic/pokemon_name_checker.dart';
import 'package:pokemon_list/widgets/pokemon_box_image.dart';
import 'package:pokemon_list/widgets/separate_sliders.dart';

import '../screens/pokemon_details_screen.dart';

class BuildPokemonSlider extends StatelessWidget{

  final String sliderTitle;
  final List<dynamic> pokemonList;
  final int addValueList;

  final PokemonNameChecker pokemonChecker = PokemonNameChecker();

  BuildPokemonSlider(this.sliderTitle , this.pokemonList, this.addValueList, {super.key});
  @override

  Widget build(BuildContext context){
    return Column(
      // Separador con nombre de Region
      children: [
        SeparatingTitleSpaceSliders(pokemonList, sliderTitle, addValueList),
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
                  onTap: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PokemonDetailsScreen(pokemon: pokemonFinalName,
                            imageUrl: imageUrl,
                            imageUrl2: imageUrl2,),
                    ),
                  ),
                child: PokemonBoxImage(pokemonFinalName, imageUrl, imageUrl2, pokemonId),
              );
            },
          ),
        ),
      ],
    );
  }
}