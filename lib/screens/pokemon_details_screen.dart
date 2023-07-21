import 'package:flutter/material.dart';
import 'package:pokemon_list/logic/api_data_logic.dart';
import 'package:pokemon_list/widgets/pokemon_Evolution_chain.dart';
import 'package:pokemon_list/widgets/pokemon_front_back_display_box_with_background.dart';
import 'package:pokemon_list/widgets/pokemon_details_base_stats_data.dart';
import 'package:pokemon_list/widgets/text_title_with_shadow.dart';
import 'package:pokemon_list/widgets/horizontal_list_data.dart';
import '../logic/pokemon_name_checker.dart';
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
  final PokemonDataFetchLogic pokemonDataFetchLogic = PokemonDataFetchLogic();
  final PokemonNameChecker pokemonChecker = PokemonNameChecker();

  late Future<dynamic> pokemonData;

  List<dynamic> pokemonTypes = [];
  List<dynamic> pokemonWeight = ["Weight"];
  List<dynamic> pokemonHeight = ["Height"];
  List<dynamic> stats = [];
  bool imageFrontDisplayed = true;
  late bool hasPokemonEvolutionChain;
  List<dynamic> pokemonEvolutionsChain = [];

  late int pokemonId1;
  List<dynamic> pokemonName1WithUrl =[];
  List<dynamic> pokemon1Types =[];

  late int pokemonId2;
  List<dynamic> pokemonName2WithUrl =[];
  List<dynamic> pokemon2Types =[];

  late String pokeEvolutionTitle;

  @override
  void initState() {
    super.initState();
    pokemonData = fetchPokemonData();
  }

  Future<void> fetchPokemonData() async {
    try {
      //Fetch Data
      final pokemonWeightData = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v1/pokemon/${widget.pokemonId}", characteristics: 'weight');
      final pokemonHeightData = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v1/pokemon/${widget.pokemonId}", characteristics: 'height');
      final pokemonTypesData = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v1/pokemon/${widget.pokemonId}", characteristics: 'types');
      final pokemonStatsData = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v1/pokemon/${widget.pokemonId}", characteristics: 'stats');
      final pokemonEvolutionURL = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v2/pokemon-species/${widget.pokemonId}", characteristics: 'evolution_chain');
      final pokemonEvolutionData = await apiService.fetchPokemonData(url: pokemonEvolutionURL["url"], characteristics: 'chain');

      final double pokemonWeightData2ble = pokemonWeightData.toDouble() / 10;
      final double pokemonHeightData2ble = pokemonHeightData.toDouble() / 10;

      //Values Logic - data Obtained to be worked with
      pokemonTypes = pokemonDataFetchLogic.dataFetchTwoLayers(pokemonTypesData,"type","name");
      pokemonWeight.add('$pokemonWeightData2ble kg');
      pokemonHeight.add('$pokemonHeightData2ble m');
      stats = pokemonDataFetchLogic.dataFetchOneLayer(pokemonStatsData,"base_stat");
      hasPokemonEvolutionChain = (pokemonDataFetchLogic.dataFetchPokemonEvolution(pokemonEvolutionData))[0];
      pokemonEvolutionsChain = (pokemonDataFetchLogic.dataFetchPokemonEvolution(pokemonEvolutionData))[1];

      //Pokemon Has NO Evolution Function
      if(hasPokemonEvolutionChain==false){
        pokemonId1 = widget.pokemonId-1;
        final pokemonName1 = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v2/pokemon/$pokemonId1", characteristics: 'name');
        pokemonName1WithUrl = pokemonChecker.lineChecker(pokemonName1);
        final pokemon1TypesData = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v1/pokemon/$pokemonId1", characteristics: 'types');
        pokemon1Types = pokemonDataFetchLogic.dataFetchTwoLayers(pokemon1TypesData,"type","name");

        pokemonId2 = widget.pokemonId+1;
        if(pokemonId2 > 721){
          pokemonId2 = 721;
        }
        final pokemonName2 = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v2/pokemon/$pokemonId2", characteristics: 'name');
        pokemonName2WithUrl = pokemonChecker.lineChecker(pokemonName2);
        final pokemon2TypesData = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v1/pokemon/$pokemonId2", characteristics: 'types');
        pokemon2Types = pokemonDataFetchLogic.dataFetchTwoLayers(pokemon2TypesData,"type","name");
        pokeEvolutionTitle = "Prev/Next Pokemon";
      }
      //Pokemon Has Evolution Function
      else{
        pokemonId1 = widget.pokemonId-1;
        if(pokemonId1==0){
          pokemonId1 = 1;
        }
        final pokemonName1 = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v2/pokemon/$pokemonId1", characteristics: 'name');
        pokemonName1WithUrl = pokemonChecker.lineChecker(pokemonName1);
        final pokemon1TypesData = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v1/pokemon/$pokemonId1", characteristics: 'types');
        pokemon1Types = pokemonDataFetchLogic.dataFetchTwoLayers(pokemon1TypesData,"type","name");

        pokemonId2 = widget.pokemonId+1;
        final pokemonName2 = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v2/pokemon/$pokemonId2", characteristics: 'name');
        pokemonName2WithUrl = pokemonChecker.lineChecker(pokemonName2);
        final pokemon2TypesData = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v1/pokemon/$pokemonId2", characteristics: 'types');
        pokemon2Types = pokemonDataFetchLogic.dataFetchTwoLayers(pokemon2TypesData,"type","name");

        pokeEvolutionTitle = "Prev/Next Pokemon";
        return;
      }

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
                        PokemonGifVisualWithBackground(
                          imageFrontDisplayed: imageFrontDisplayed,
                          types: pokemonTypes, imageUrl: widget.imageUrl,
                          imageUrl2: widget.imageUrl2,
                          boxWidth: 300,
                          boxHeight: 180,
                        ),
                        const SizedBox(height: 20,),
                        HorizontalDataDisplay(pokemonTypes),
                        const SizedBox(height: 10,),
                        HorizontalDataDisplay(pokemonWeight),
                        const SizedBox(height: 10,),
                        HorizontalDataDisplay(pokemonHeight),
                        const SizedBox(height: 30,),
                        PokemonStatsBaseAll(stats),
                        PokemonEvolutionChainImages(
                            pokemonId1,
                            pokemonName1WithUrl,
                            pokemon1Types,
                            pokemonId2,
                            pokemonName2WithUrl,
                            pokemon2Types,
                            pokeEvolutionTitle,),
                        const SizedBox(height: 30,),
                      ])
              ),
              );
          }
          else{
            return Center(
              widthFactor: double.infinity,
              child: Image.asset('images/loader1.gif',
                alignment: Alignment.center,
                width: double.infinity,
                fit: BoxFit.fitHeight,
                filterQuality: FilterQuality.high,
              ),
            );
          }
        }
      )
    );
  }
}
