import 'package:flutter/material.dart';

class PokemonDetailsInfoTitle extends StatelessWidget{

  final String pokeTitle;
  const PokemonDetailsInfoTitle(this.pokeTitle, {super.key});

  @override
  Widget build (BuildContext context){
    return Container(
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
      child: Text(
        pokeTitle,
        style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
    );
  }
}