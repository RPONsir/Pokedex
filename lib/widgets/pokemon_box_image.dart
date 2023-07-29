import 'package:flutter/material.dart';
import 'package:pokemon_list/widgets/pokemon_gif.dart';
import 'package:pokemon_list/widgets/pokemon_id_text.dart';
import 'package:pokemon_list/widgets/pokemon_name_text.dart';

class PokemonBoxImage extends StatelessWidget {
  final String pokemonFinalName;
  final String imageUrl;
  final String imageUrl2;
  final int pokemonId;

  const PokemonBoxImage(
      this.pokemonFinalName,
      this.imageUrl,
      this.imageUrl2,
      this.pokemonId,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.black),
          color: Colors.black,
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image.asset(
              'images/listBackground.jpeg',
              width: 150,
              fit: BoxFit.fitWidth,),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PokemonIdText(pokemonId, 18),
                const SizedBox(height: 8),
                PokemonGif(imageUrl, imageUrl2, 150, 110, true),
                const SizedBox(height: 3),
                PokemonNameText(pokemonFinalName, 18),
                const SizedBox(height: 6),
              ],
            ),
          ],
        ),
    );
  }
}