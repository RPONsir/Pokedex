import 'package:flutter/material.dart';
import 'package:pokemon_list/widgets/error_screen_image.dart';
import 'package:pokemon_list/widgets/text_title_with_shadow.dart';

class PokemonDetailsScreenError extends StatelessWidget {

  final dynamic pokemonName;

  const PokemonDetailsScreenError({Key? key, required this.pokemonName, }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 10,
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title:
        const TitleWithShadow('Poke-Error', 40),
      ),
      body: Center(
        child: ListView(
              children: const [
                ErrorImage('images/errorPsyduckOut.jpeg'),
                SizedBox(
                    height: 70
                ),
                ErrorImage('images/whosThatPokemon.png'),
              ]
            ),
          ),
    );
  }
}