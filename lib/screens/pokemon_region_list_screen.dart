import 'package:flutter/material.dart';
import 'package:pokemon_list/widgets/build_pokemon_grid.dart';
import 'package:pokemon_list/widgets/build_pokemon_searcher.dart';
import 'package:pokemon_list/widgets/text_title_with_shadow.dart';

class PokemonRegionList extends StatelessWidget{

  final List<dynamic> regionPokemonList;
  final String regionName;
  final int addValue;

  const PokemonRegionList({Key? key, required this.regionPokemonList, required this.regionName, required this.addValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 10,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleWithShadow(regionName, 32),
            ],
          ),
          backgroundColor: Colors.redAccent,
          bottom: PreferredSize(
            preferredSize:
            const Size.fromHeight(80.0),
            child: BuildPokemonSearcher(context, regionPokemonList,),
          ),
          actions: const [
          ],
        ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildPokemonGrid(regionPokemonList, addValue),
            ],
        ),
      ),
    );
  }
}