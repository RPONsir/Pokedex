import 'package:flutter/material.dart';

class PokemonNameText extends StatelessWidget{

  final String pokemonFinalName;
  final double fontSize;
  const PokemonNameText(this.pokemonFinalName, this.fontSize, {super.key});

  @override
  Widget build(BuildContext context,){
    return Text(
      pokemonFinalName.toUpperCase(),
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.7),
            offset: const Offset(1, 1),
            blurRadius: 3,
          ),
        ],
      ),
    );
  }

}