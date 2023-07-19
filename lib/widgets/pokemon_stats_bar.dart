import 'package:flutter/material.dart';

class PokemonStatsBar extends StatelessWidget{
  final String statsName;
  final int statsValue;

  const PokemonStatsBar(this.statsName, this.statsValue, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.blueAccent,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5),
          width: 120,
          height: 50,
          child: Text(statsName,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        Container(
          color: Colors.lightBlueAccent,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5),
          width: 180,
          height: 50,
          child: Text(statsValue.toString(),
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        )
      ],
    );

  }

}