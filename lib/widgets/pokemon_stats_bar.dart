import 'package:flutter/material.dart';

class PokemonStatsBarSingle extends StatelessWidget{
  final String statsName;
  final int statsValue;

  const PokemonStatsBarSingle(this.statsName, this.statsValue, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5),
          width: 130,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 5,
            ),
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(30),),
            color: Colors.redAccent,
          ),
          child: Text(statsName,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5),
          width: 170,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 5,
            ),
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(30),),
            color: Colors.white,

          ),
          child: Text(statsValue.toString(),
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        )
      ],
    );

  }

}