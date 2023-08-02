import 'package:flutter/material.dart';
import 'package:pokemon_list/widgets/pokemon_details_info_title.dart';
import 'package:pokemon_list/widgets/pokemon_stats_bar.dart';

class PokemonStatsBaseAll extends StatelessWidget{

  final List<dynamic> stats;

  const PokemonStatsBaseAll(this.stats, {super.key});

  @override
  Widget build(BuildContext context ){
    return Column(
      children: [
        const PokemonDetailsInfoTitle("BASE STATS", Colors.grey),
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