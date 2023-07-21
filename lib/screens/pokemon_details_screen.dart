import 'package:flutter/material.dart';
import 'package:pokemon_list/logic/api_data_logic.dart';
import 'package:pokemon_list/widgets/pokemon_stats_bar.dart';
import 'package:pokemon_list/widgets/text_title_with_shadow.dart';
import 'package:pokemon_list/widgets/pokemon_gif.dart';
import 'package:pokemon_list/widgets/horizontal_list_data.dart';
import '../obtainData/pokemon_api_service.dart';

class PokemonDetailsScreen extends StatefulWidget {
  final dynamic pokemon;
  final dynamic imageUrl;
  final dynamic imageUrl2;
  final dynamic pokemonId;

  const PokemonDetailsScreen({Key? key, required this.pokemon, required this.imageUrl, required this.imageUrl2, required this.pokemonId,}) : super(key: key);
  @override
  State<PokemonDetailsScreen> createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  final PokemonApiService apiService = PokemonApiService();
  final TypesLogic typesLogic = TypesLogic();

  late Future<dynamic> pokemonData;

  List<dynamic> types = [];
  List<dynamic> pokemonHeight = ["Height"];
  List<dynamic> pokemonWeight = ["Weight"];
  List<dynamic> stats = [];
  bool imageFrontDisplayed = true;

  @override
  void initState() {
    super.initState();
    pokemonData = fetchPokemonData();
  }

  Future<void> fetchPokemonData() async {
    try {
      final pokemonWeightData = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v1/pokemon/${widget.pokemonId}", characteristics: 'weight');
      final pokemonHeightData = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v1/pokemon/${widget.pokemonId}", characteristics: 'height');
      final pokemonTypesData = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v1/pokemon/${widget.pokemonId}", characteristics: 'types');
      final pokemonStatsData = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v1/pokemon/${widget.pokemonId}", characteristics: 'stats');

      final double pokemonWeightData2ble = pokemonWeightData.toDouble() / 10;
      final double pokemonHeightData2ble = pokemonHeightData.toDouble() / 10;
      pokemonWeight.add('$pokemonWeightData2ble kg');
      pokemonHeight.add('$pokemonHeightData2ble m');
      types = typesLogic.typesData(pokemonTypesData);
      stats = typesLogic.statsData(pokemonStatsData);
      return;

    } catch (e) {
      // Handle error
      print('Failed to fetch Pokemon list: $e');
    }
  }

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
            alignment: Alignment.center,
            width: 80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                /*Image.asset(
                  'images/Poke_Ball.webp',
                  width: 80,
                  height: 80,
                ),
                */
                Text("#${widget.pokemonId.toString()}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.7),
                        offset: const Offset(3, 3),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]
      ),

      body: FutureBuilder(
        future: pokemonData,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return
              SingleChildScrollView(
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
                        HorizontalDataDisplay(pokemonWeight),
                        const SizedBox(height: 20,),
                        HorizontalDataDisplay(pokemonHeight),
                        const SizedBox(height: 20,),
                        PokemonStatsBar("HP", stats[0]),
                        PokemonStatsBar("ATTACK", stats[1]),
                        PokemonStatsBar("DEFENSE", stats[2]),
                        PokemonStatsBar("SP. ATK", stats[3]),
                        PokemonStatsBar("SP. DEF", stats[4]),
                        PokemonStatsBar("SPEED", stats[5]),
                        const SizedBox(height: 30,),
                      ])
              ),
              );
          }
          else{
            return Center(
              widthFactor: double.infinity,
              child: Image.asset('images/loader1.gif',
                width: 300,
                height: 300,
                fit: BoxFit.fitHeight,),
            );
          }
        }

      )
      /*
      SingleChildScrollView(
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
                  FutureBuilder(
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return
                  const SizedBox(height: 30,),
                  HorizontalDataDisplay(types),
                  const SizedBox(height: 20,),
                  HorizontalDataDisplay(pokemonWeight),
                  const SizedBox(height: 20,),
                  HorizontalDataDisplay(pokemonHeight),
                  const SizedBox(height: 20,),
                  PokemonStatsBar("HP", stats[0]),
                  PokemonStatsBar("ATTACK", stats[1]),
                  PokemonStatsBar("DEFENSE", stats[2]),
                  PokemonStatsBar("SP. ATK", stats[3]),
                  PokemonStatsBar("SP. DEF", stats[4]),
                  PokemonStatsBar("SPEED", stats[5]),
                  const SizedBox(height: 30,),
                  }
          else{
            return const CircularProgressIndicator();
          }
        }

      )
                ])
        ),
      ),
      */
    );
  }
}
