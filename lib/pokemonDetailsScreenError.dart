import 'package:flutter/material.dart';

class PokemonDetailsScreenError extends StatelessWidget {

  final dynamic pokemonName;

  PokemonDetailsScreenError({Key? key, required this.pokemonName, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //fetchPokemonData(index);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Row(
          children:[
            _titleText(),
          ],
        ),
      ),
      body: Center(
        child: ListView(
              children: [
                _psyDuckImage(),
                const SizedBox(
                    height: 50
                ),
                _whosThatPokemonImage()
              ]
            ),
          ),
    );
  }
}

Widget _titleText(){
  return Container(
    alignment: Alignment.center,
    width: 250,
    child: Text('Error', textAlign: TextAlign.center,
      style: TextStyle(
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.7),
              offset: const Offset(3, 3),
              blurRadius: 5,
            ),
          ],
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.yellow),
    ),
  );
}

Widget _psyDuckImage(){
  return Image.asset(
    'images/errorPsyduckOut.jpeg',
    height: 300,
    fit: BoxFit.fill,
  );
}

Widget _whosThatPokemonImage(){
  return Image.asset(
    'images/whosThatPokemon.png',
    height: 350,
    fit: BoxFit.fill,
  );
}