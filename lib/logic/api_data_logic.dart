import 'package:flutter/material.dart';

class TypesLogic{
  // Obtains data Base Stats for Pokemon
  statsData(data){
    final List stats = [];
    for (int i = 0; i < data.length; i++) {
      final data1 = data[i];
      final statsToAdd = data1['base_stat'];
      stats.add(statsToAdd);
    }
    return stats;
  }
  // Obtain data Types for Pokemon
  typesData(data){
    final List types = [];
    for (int i = 0; i < data.length; i++) {
      final data1 = data[i];
      final data2 = data1["type"];
      final data3 = data2["name"];
      types.add(data3.toUpperCase());
    }
    return types;
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
}