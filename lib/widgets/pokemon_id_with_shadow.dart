import 'package:flutter/material.dart';

class PokemonIdWithShadow extends StatelessWidget {
  final String pokemonId;
  final double fontSize;

  const PokemonIdWithShadow(this.pokemonId, this.fontSize, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 80,
      child: Text(
        "#${pokemonId.toString()}",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.yellow,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.7),
              offset: const Offset(3, 3),
              blurRadius: 5,
            ),
          ],
        ),
      ),
    );
  }
}
