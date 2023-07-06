import 'package:flutter/material.dart';
import 'obtainData.dart';

class PokemonDetailsScreen extends StatelessWidget {

  final ObtainData obtainPokemonData = ObtainData();
  final dynamic pokemon;
  final dynamic imageUrl;
  List<dynamic> types = [];
  List<dynamic> body = [];
  var colorChange;

  PokemonDetailsScreen({Key? key, required this.pokemon, required this.imageUrl,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    types.addAll(["Type 1", "Type 2",]);
    body.addAll(["Height", "Weight",]);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Row(
          children:[
            _titleText(pokemon),
            _titleImage(imageUrl)
          ],
        ),
      ),

      body: Center(
          child: Column(
              children: [
                _types(types),
                _body(body),
              ])
      ),
    );
  }
}

Widget _titleText(pokemon){
  return Container(
    alignment: Alignment.center,
    width: 250,
    child: Text(pokemon.toUpperCase(), textAlign: TextAlign.center,
      style: TextStyle(
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.7),
              offset: const Offset(3, 3),
              blurRadius: 5,
            ),
          ],
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.yellow),
    ),
  );
}

Widget _titleImage(imageUrl){
  return Container(
    alignment: Alignment.centerRight,
    width: 70,
    child:
    FadeInImage(
      width: 70,
      height: 60,
      placeholder: const AssetImage("images/pokeLoader.gif"), alignment: Alignment.bottomCenter,
      image: NetworkImage(imageUrl,),
      fit: BoxFit.contain,
    ),
  );
}

Widget _body(List types){
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Container(
          height: 100,
          width: 340,
          color: Colors.blue,
          alignment: Alignment.center,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: types.length,
              itemBuilder: (context, index){
                return Container(
                    height: 50,
                    width: 150,
                    color: Colors.white,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(10),
                    child:
                    Text(types[index].toString(),textAlign: TextAlign.center,)
                );
              }
          ),
        )
      ]
  );
}

Widget _types(List types){
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Container(
            height: 100,
            width: 340,
            color: Colors.blue,
            alignment: Alignment.center,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: types.length,
              itemBuilder: (context, index){
                final copy = types[index].toString();
                return Container(
                    height: 50,
                    width: 150,
                    color: Colors.white,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(10),
                    child:
                    Text(types[index].toString(),textAlign: TextAlign.center,)
                );
              }
          ),
        )
      ]
  );
}