import 'package:flutter/material.dart';
import 'package:pokemon_list/widgets/text_title_with_shadow.dart';
import 'package:pokemon_list/widgets/pokemon_gif.dart';
import 'package:pokemon_list/widgets/horizontal_list_data.dart';
import '../obtainData/obtain_data.dart';

class PokemonDetailsScreen extends StatefulWidget {
  final dynamic pokemon;
  final dynamic imageUrl;
  final dynamic imageUrl2;
  const PokemonDetailsScreen({Key? key, required this.pokemon, required this.imageUrl, required this.imageUrl2}) : super(key: key);
  @override
  State<PokemonDetailsScreen> createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  final ObtainData obtainPokemonData = ObtainData();

  List<dynamic> types = ["Type 1", "Type 2",];
  List<dynamic> bodyStatus = ["Height: 85",];
  bool imageFrontDisplayed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        elevation: 10,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleWithShadow(widget.pokemon, 32),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () => {
              if(imageFrontDisplayed == true){
                setState(() {
                  imageFrontDisplayed = false;
                }),
              }
              else{
                setState(() {
                  imageFrontDisplayed = true;
                }),
              }
              },
            child: Container(
            alignment: Alignment.centerRight,
            width: 70,
            child: PokemonGif(widget.imageUrl, widget.imageUrl2, 70, 60, imageFrontDisplayed),
            ),
          ),
        ]
      ),

      body: SingleChildScrollView(
        child: Center(
            child: Column(
                children: [
                  const SizedBox(height: 50,),
                  HorizontalDataDisplay(types),
                  const SizedBox(height: 50,),
                  HorizontalDataDisplay(bodyStatus),
                  const SizedBox(height: 50,),
                ])
        ),
      ),
    );
  }
}
