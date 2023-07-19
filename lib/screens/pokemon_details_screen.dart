import 'package:flutter/material.dart';
import 'package:pokemon_list/widgets/pokemon_stats_bar.dart';
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
  List<dynamic> bodyStatus1 = ["Height:", "85"];
  List<dynamic> bodyStatus2 = ["Weight:", "30"];
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
          Container(
            alignment: Alignment.centerRight,
            width: 70,
            child: Image.asset('images/Poke_Ball.webp', width:60, height:50,),
            ),
        ]
      ),

      body: SingleChildScrollView(
        child: Center(
            child: Column(
                children: [
                  const SizedBox(height: 30,),
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
                      color: Colors.black,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      width: 300,
                      height: 180,
                      child: Stack(
                        children:[
                          Image.asset('images/backgroundPokemongrass.png.webp', width:280, height:160,fit: BoxFit.fitHeight,),
                          PokemonGif(widget.imageUrl, widget.imageUrl2, 280, 140, imageFrontDisplayed),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  HorizontalDataDisplay(types),
                  const SizedBox(height: 20,),
                  HorizontalDataDisplay(bodyStatus1),
                  const SizedBox(height: 20,),
                  HorizontalDataDisplay(bodyStatus2),
                  const SizedBox(height: 20,),
                  PokemonStatsBar("HP", 50),
                  PokemonStatsBar("ATTACK", 50),
                  PokemonStatsBar("DEFENSE", 100),
                  PokemonStatsBar("SP. ATK", 35),
                  PokemonStatsBar("SP. DEF", 2),
                  PokemonStatsBar("SPEED", 18),
                  const SizedBox(height: 30,),
                ])
        ),
      ),
    );
  }
}
