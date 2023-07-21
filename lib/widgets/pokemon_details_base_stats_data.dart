import 'package:flutter/material.dart';
import 'package:pokemon_list/widgets/pokemon_stats_bar.dart';

class PokemonStatsBaseAll extends StatelessWidget{

  final List<dynamic> stats;

  const PokemonStatsBaseAll(this.stats, {super.key});

  @override
  Widget build(BuildContext context ){
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5),
          width: 300,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10),),
            color: Colors.grey,
          ),
          child: const Text('Base Stats',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        const SizedBox(height: 20,),
        PokemonStatsBarSingle("HP", stats[0]),
        const SizedBox(height: 10,),
        PokemonStatsBarSingle("ATTACK", stats[1]),
        const SizedBox(height: 10,),
        PokemonStatsBarSingle("DEFENSE", stats[2]),
        const SizedBox(height: 10,),
        PokemonStatsBarSingle("SP. ATK", stats[3]),
        const SizedBox(height: 10,),
        PokemonStatsBarSingle("SP. DEF", stats[4]),
        const SizedBox(height: 10,),
        PokemonStatsBarSingle("SPEED", stats[5]),
        const SizedBox(height: 30,),
      ],
    );
  }

}