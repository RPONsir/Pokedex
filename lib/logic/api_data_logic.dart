import 'package:flutter/material.dart';

class PokemonDataFetchLogic{
  // Obtains data 1 layer of jsonFile
  dataFetchOneLayer(data, String layer1){
    final List obtainedData = [];
    for (int i = 0; i < data.length; i++) {
      final data1 = data[i];
      final statsToAdd = data1[layer1];
      obtainedData.add(statsToAdd);
    }
    return obtainedData;
  }
  // Obtains data 2 layer of jsonFile
  dataFetchTwoLayers(data , String layer1, String layer2){
    final List obtainedData = [];
    for (int i = 0; i < data.length; i++) {
      final data1 = data[i];
      final data2 = data1[layer1];
      final data3 = data2[layer2];
      obtainedData.add(data3.toUpperCase());
    }
    return obtainedData;
  }

  dataFetchSecondEvolutionIsAvailable(data , String layer1, String layer2, String pokemonName){
    final List obtainedData = [];
    List pokemonsUrl = dataFetchTwoLayers(data,'species',"url");
    int pokemonQuantity = pokemonsUrl.length;
    for(int i = 0; i < pokemonQuantity; i++) {
      final data1 = data[i];
      final data2 = data1[layer1];
      final data3 = data2[layer2];
      // E.g https://pokeapi.co/api/v2/pokemon-species/
      // Remove first 42 char and Remove last char "/" from URL to obtain a number
      String obtainedUrl = pokemonsUrl[i].toString().substring(42, (pokemonsUrl[i].length-1));
      int pokemonId = int.parse(obtainedUrl);
      if(pokemonId>721){
        //Do Nothing
      }
      else{
        obtainedData.add(data3);
      }
    }
    return obtainedData;

  }
  // Obtains data 3 layer of jsonFile
  dataFetchThirdEvolutionIsAvailable(data , String layer1, String layer2, String layer3){
    final List obtainedData = [];
    final datalayer = data[0];
    List pokemonsUrl = dataFetchTwoLayers(datalayer[layer1],'species',"url");
    int pokemonQuantity = pokemonsUrl.length;
    for(int i = 0; i < pokemonQuantity; i++) {
      final data1 = data[0];
      final data2 = data1[layer1];
      if((data2?.isEmpty ?? true)){
        return obtainedData;
      }
      else{
        final data3 = data2[i];
        final data4 = data3[layer2];
        final data5 = data4[layer3];
        obtainedData.add(data5);
      }
    }
    return obtainedData;
  }
  // Idea to change color based on Type
  textToColor(String type){
    final Color typeColor;
    if(type=='NORMAL'){
      typeColor = Colors.amberAccent;
      return typeColor;
    }
    else if(type=='FIRE'){
      typeColor = Colors.red;
      return typeColor;
    }
    else if(type=='FIGHTING'){
      typeColor = Colors.amber;
      return typeColor;
    }
    else if(type=='WATER'){
      typeColor = Colors.blue;
      return typeColor;
    }
    else if(type=='FLYING'){
      typeColor = Colors.white70;
      return typeColor;
    }
    else if(type=='GRASS'){
      typeColor = Colors.green;
      return typeColor;
    }
    else if(type=='POISON'){
      typeColor = Colors.purple;
      return typeColor;
    }
    else if(type=='ELECTRIC'){
      typeColor = Colors.yellow;
      return typeColor;
    }
    else if(type=='GROUND'){
      typeColor = Colors.brown;
      return typeColor;
    }
    else if(type=='PSYCHIC'){
      typeColor = Colors.pink;
      return typeColor;
    }
    else if(type=='ROCK'){
      typeColor = Colors.grey;
      return typeColor;
    }
    else if(type=='ICE'){
      typeColor = Colors.cyanAccent;
      return typeColor;
    }
    else if(type=='BUG'){
      typeColor = Colors.lightGreen;
      return typeColor;
    }
    else if(type=='DRAGON'){
      typeColor = Colors.deepPurpleAccent;
      return typeColor;
    }
    else if(type=='GHOST'){
      typeColor = Colors.deepPurple;
      return typeColor;
    }
    else if(type=='DARK'){
      typeColor = Colors.indigo;
      return typeColor;
    }
    else if(type=='STEEL'){
      typeColor = Colors.blueGrey;
      return typeColor;
    }
    else if(type=='FAIRY'){
      typeColor = Colors.pinkAccent;
      return typeColor;
    }
    else if(type=='Weight'){
      typeColor = Colors.redAccent;
      return typeColor;
    }
    else if(type=='Height'){
      typeColor = Colors.redAccent;
      return typeColor;
    }
    else{
      typeColor = Colors.white;
      return typeColor;
    }
  }

  // Function Check if the pokemon has Valid EvolutionsChain until the 6th Generation (721 pokemonList)
  dataFetchPokemonEvolution(data){
    bool hasPokemonEvolutionChain;
    List pokemonEvolutionChain=[];
    // If empty value comes in here - there are no evolution chain
    if(data["evolves_to"]?.isEmpty ?? true){
      hasPokemonEvolutionChain=false;
      pokemonEvolutionChain.add("No Evolution Chain");
      return[hasPokemonEvolutionChain, pokemonEvolutionChain, "No Evolution Chain"];
    }
    // If a value is found - a evolution chain is available
    else{
      List url = dataFetchTwoLayers(data['evolves_to'],'species',"url");
      // E.g https://pokeapi.co/api/v2/pokemon-species/
      // Remove first 42 char and Remove last char "/" from URL to obtain a number
      String obtainedUrl = url[0].toString().substring(42, (url[0].length-1));
      int pokemonId = int.parse(obtainedUrl);
      // Limit is 721 , for new generation evolution will not be added to this app
      if(pokemonId>721){
        hasPokemonEvolutionChain=false;
        pokemonEvolutionChain.add("No Evolution Chain");
        return[hasPokemonEvolutionChain, pokemonEvolutionChain, "No Evolution Chain"];
      }
      else{
        hasPokemonEvolutionChain=true;
        //Obtain First Pokemon Evolution
        var pokemonChain1 = data['species'];
        String pokemonName1 = pokemonChain1['name'];
        pokemonEvolutionChain.add(pokemonName1);

        // Check Second Evolution
        List pokemonName2 = dataFetchSecondEvolutionIsAvailable(data['evolves_to'],'species',"name",pokemonName1);
        pokemonEvolutionChain.add(pokemonName2.join(', ').toString());

        // Look into the 3rd evolution if available
        List pokemonName3 = dataFetchThirdEvolutionIsAvailable(data['evolves_to'],'evolves_to','species','name');

        if(pokemonName3.isEmpty){
          // as an empty value is coming do nothing
        }
        else{
          List url2 = dataFetchThirdEvolutionIsAvailable(data['evolves_to'],'evolves_to','species',"url");
          // E.g https://pokeapi.co/api/v2/pokemon-species/
          // Remove first 42 char and Remove last char "/" from URL to obtain a number
          String obtainedUrl2 = url2[0].toString().substring(42, (url2[0].length-1));
          int pokemonId2 = int.parse(obtainedUrl2);
          if(pokemonId2>721){
            // Do Nothing
          }
          else{
            //Third evolution found, add to list
            pokemonEvolutionChain.add(pokemonName3.join(', ').toString());
          }
        }
        return[hasPokemonEvolutionChain, pokemonEvolutionChain, "See Evolution Chain"];
      }
    }
  }
}