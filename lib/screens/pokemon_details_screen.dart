import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokemon_list/logic/api_data_logic.dart';
import 'package:pokemon_list/screens/pokemon_list_screen.dart';
import 'package:pokemon_list/widgets/error_message_no_internet.dart';
import 'package:pokemon_list/widgets/pokemon_id_with_shadow.dart';
import 'package:pokemon_list/widgets/build_pokemon_prev_next_images_link.dart';
import 'package:pokemon_list/widgets/pokemon_front_back_display_box_with_background.dart';
import 'package:pokemon_list/widgets/build_pokemon_details_base_stats_data.dart';
import 'package:pokemon_list/widgets/pokemon_text_title_with_shadow.dart';
import 'package:pokemon_list/widgets/pokemon_horizontal_list_data.dart';
import 'package:pokemon_list/widgets/pokemon_screen_loader.dart';
import '../logic/pokemon_name_checker.dart';
import '../obtainData/pokemon_api_service.dart';
import '../widgets/pokemon_details_info_title.dart';

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
  late List<dynamic> pokemonEvolutionsChain = [];
  late String pokemonEvolutionChainTitle;

  late int pokemonId1;
  List<dynamic> pokemonName1WithUrl =[];
  List<dynamic> pokemon1Types =[];

  late int pokemonId2;
  List<dynamic> pokemonName2WithUrl =[];
  List<dynamic> pokemon2Types =[];

  late String pokePrevNextTitle;

  late bool isDeviceConnected;
  late String isAlertSet = 'unknown';

  @override
  void initState() {
    super.initState();
    pokemonData = fetchPokemonData();
  }

  Future<void> fetchPokemonData() async {
    try {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if(isDeviceConnected == true){
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

        // Pokemon Evolution parameters and logic
        hasPokemonEvolutionChain = (pokemonDataFetchLogic.dataFetchPokemonEvolution(pokemonEvolutionData))[0];
        pokemonEvolutionsChain = (pokemonDataFetchLogic.dataFetchPokemonEvolution(pokemonEvolutionData))[1];
        pokemonEvolutionChainTitle = (pokemonDataFetchLogic.dataFetchPokemonEvolution(pokemonEvolutionData))[2];

        pokemonId1 = widget.pokemonId-1;
        if(pokemonId1==0){
          pokemonId1 = 1;
        }
        final pokemonName1 = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v2/pokemon/$pokemonId1", characteristics: 'name');
        pokemonName1WithUrl = pokemonChecker.nameCheckerGetImageURL(pokemonName1);
        final pokemon1TypesData = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v1/pokemon/$pokemonId1", characteristics: 'types');
        pokemon1Types = pokemonDataFetchLogic.dataFetchTwoLayers(pokemon1TypesData,"type","name");

        pokemonId2 = widget.pokemonId+1;
        if(pokemonId2 > 721){
          pokemonId2 = 721;
        }
        final pokemonName2 = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v2/pokemon/$pokemonId2", characteristics: 'name');
        pokemonName2WithUrl = pokemonChecker.nameCheckerGetImageURL(pokemonName2);
        final pokemon2TypesData = await apiService.fetchPokemonData(url: "https://pokeapi.co/api/v1/pokemon/$pokemonId2", characteristics: 'types');
        pokemon2Types = pokemonDataFetchLogic.dataFetchTwoLayers(pokemon2TypesData,"type","name");
        pokePrevNextTitle = "Prev/Next Pokemon";
        setState(() => isAlertSet = 'false');
      }
      else{
        setState(() => isAlertSet = 'true');
      }
      //Fetch Data

    } catch (e) {
      // Handle error
      //print('Failed to fetch Pokemon list: $e');
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleWithShadow(widget.pokemon, 26),
          ],
        ),
        actions: [
          PokemonIdWithShadow(widget.pokemonId.toString(),22),
        ]
      ),

      body: FutureBuilder(
        future: pokemonData,
        builder: (context, snapshot){
          if((snapshot.connectionState == ConnectionState.done)&&(isAlertSet=='false')){
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
                          edgeSpacing: 10,
                        ),
                        const SizedBox(height: 20,),
                        HorizontalDataDisplay(pokemonTypes),
                        const SizedBox(height: 10,),
                        HorizontalDataDisplay(pokemonWeight),
                        const SizedBox(height: 10,),
                        HorizontalDataDisplay(pokemonHeight),
                        const SizedBox(height: 30,),
                        PokemonStatsBaseAll(stats),
                        PokemonPrevNextImagesWithTitleAndLink(
                            pokemonId1,
                            pokemonName1WithUrl,
                            pokemon1Types,
                            pokemonId2,
                            pokemonName2WithUrl,
                            pokemon2Types,
                            pokePrevNextTitle,),
                        const SizedBox(height: 10,),
                        PokemonDetailsInfoTitle(pokemonEvolutionChainTitle.toString()),
                        const SizedBox(height: 30,),
                        Container(
                          width: 300,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.lime,
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              color: Colors.black,
                              width: 3,
                            ),
                          ),
                          child: Text(pokemonEvolutionsChain.join(', ').toString().toUpperCase(),
                              textWidthBasis: TextWidthBasis.parent,
                              maxLines: 4,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              )),
                        ),
                        const SizedBox(height: 30,),
                      ])
              ),
              );
          }
          else if(isAlertSet=='true'){
            return const InternetErrorMessage();
          }
          else{
            return const ScreenLoader();
          }
        }
      ),
      bottomNavigationBar: BottomNavigationBar (
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.catching_pokemon),
              label: 'Pokemon',
            ),
          ],
        onTap: (index) {
          if(index==0){
            Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(
              builder: (context) =>
              const PokemonListScreen(),
              maintainState: false,
            ),
                  (Route<dynamic> route) => false,
            );
          }
          else if(index==1){
            // To be Included to add Favorites Page
          }
        },
      ),
    );
  }
}
