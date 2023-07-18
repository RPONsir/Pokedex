import 'package:flutter/material.dart';

class PokemonIdText extends StatelessWidget{

  final int pokemonId;
  final double fontSize;
  const PokemonIdText(this.pokemonId, this.fontSize, {super.key});

  @override
  Widget build(BuildContext context,){
    return Text(
      '#$pokemonId',
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        shadows: [
          Shadow(
            color: Colors.white.withOpacity(0.9),
            offset: const Offset(0, 0),
            blurRadius: 6,
          ),
        ],
      ),
    );
  }

}