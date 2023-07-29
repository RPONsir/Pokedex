import 'package:flutter/material.dart';

class TypeToColor{
  // Function to change color based on Type String
  textToColor(String type){
    final Color typeColor;
    // String in uppercase
    type = type.toUpperCase();
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