import 'package:flutter/material.dart';
import '../screens/pokemon_region_list_screen.dart';

class SeparatingTitleSpaceSliders extends StatelessWidget{

  final String sliderTitle;
  final List<dynamic> allPokemonList;
  final List<dynamic> regionPokemonList;
  final int addValue;

  const SeparatingTitleSpaceSliders(this.allPokemonList, this.regionPokemonList, this.sliderTitle, this.addValue, {super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            height: 55,
            width: double.infinity,
            color: Colors.black,
            alignment: Alignment.center,
            child:
            Text(
              sliderTitle, textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 34.0,
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    color: Colors.white.withOpacity(0.7),
                    offset: const Offset(2, 2),
                    blurRadius: 3,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () =>
                Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context) => PokemonRegionList(
                    allPokemonList: allPokemonList,
                    regionPokemonList: regionPokemonList,
                    regionName: sliderTitle,
                    addValue: addValue,),
                ),
                ),
            child: Image.asset(
              'images/arrowIcon.png',
              height: 50,
              width: 60,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
    );
  }
}