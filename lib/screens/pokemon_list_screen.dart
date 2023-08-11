import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokemon_list/logic/internet_checker.dart';
import 'package:pokemon_list/widgets/build_pokemon_searcher.dart';
import 'package:pokemon_list/widgets/build_pokemon_slider.dart';
import 'package:pokemon_list/obtainData/pokemon_api_service.dart';
import 'package:pokemon_list/widgets/pokemon_screen_loader.dart';
import 'package:pokemon_list/widgets/pokemon_weak_connection.dart';
import 'package:pokemon_list/widgets/pokemon_weak_connection_retry.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});
  @override
  PokemonListScreenState createState() => PokemonListScreenState();
}

class PokemonListScreenState extends State<PokemonListScreen> {

  final PokemonApiService apiService = PokemonApiService();
  final InternetChecker internetChecker = InternetChecker();

  late bool isDeviceConnected = false;
  late String isAlertSet = 'unknown';

  List<dynamic> allPokemonList = [];
  List<dynamic> pokemonList1 = [];
  List<dynamic> pokemonList2 = [];
  List<dynamic> pokemonList3 = [];
  List<dynamic> pokemonList4 = [];
  List<dynamic> pokemonList5 = [];
  List<dynamic> pokemonList6 = [];

  late StreamSubscription listener;

  @override
  void initState() {
    super.initState();
    internetStatus();
    fetchPokemonData();
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  Future<void> internetStatus() async {
    try {
      listener = await internetChecker.internetCheckingStatus(context);
    } catch (e) {
      // Handle error
      // print('Failed to fetch Pokemon list: $e');
      }
  }

  Future<void> fetchPokemonData() async {
    try {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if(isDeviceConnected == true){
        final pokemonData = await apiService.fetchPokemonData(url: 'https://pokeapi.co/api/v2/pokemon?limit=721', characteristics: 'results',);
        setState(() {
          // Obtain Entire Pokemon List and Divide Per Region
          allPokemonList = pokemonData;
          pokemonList1 = allPokemonList.sublist(0, 151);
          pokemonList2 = allPokemonList.sublist(151, 251);
          pokemonList3 = allPokemonList.sublist(251, 386);
          pokemonList4 = allPokemonList.sublist(386, 493);
          pokemonList5 = allPokemonList.sublist(493, 649);
          pokemonList6 = allPokemonList.sublist(649, 721);
          isAlertSet = 'false';
        });
        return;
      }
      else{
        setState(() => isAlertSet = 'true');
      }
    } catch (e) {
      // Handle error
      //print('Failed to fetch Pokemon list: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        toolbarHeight: 70,
        elevation: 10,
        centerTitle: true,
        title:
        Image.asset(
          'images/International_Pokémon_logo.svg.png',
          height: 65,
          fit: BoxFit.fitHeight,
        ),
        backgroundColor: Colors.redAccent,
        bottom: PreferredSize(
          preferredSize:
          const Size.fromHeight(80.0),
          child: BuildPokemonSearcher(context, allPokemonList, allPokemonList.length, 1),
        ),

      ),
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 4)),
        builder: (context, snapshot){
          if((snapshot.connectionState == ConnectionState.done)&&(isAlertSet=='false')){
            Future.delayed(const Duration(seconds: 5));
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildPokemonSlider('Kanto', allPokemonList, pokemonList1, 1),
                  BuildPokemonSlider('Johto', allPokemonList, pokemonList2, 152),
                  BuildPokemonSlider('Hoenn', allPokemonList, pokemonList3, 252),
                  BuildPokemonSlider('Sinnoh', allPokemonList, pokemonList4, 387),
                  BuildPokemonSlider('Teselia', allPokemonList, pokemonList5, 494),
                  BuildPokemonSlider('Kalos', allPokemonList, pokemonList6, 650),
                  Container(height: 40, width: double.infinity,color: Colors.black,),
                ],
              ),
            );
          }
          else if(isAlertSet=='true'){
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const PokemonWeakConnectionImage(),
                    GestureDetector(
                      onTap: () => {
                        setState(() {
                          isAlertSet = 'unknown';
                        }),
                        fetchPokemonData(),
                      },
                      child: const PokemonWeakConnectionRetry(),
                    ),
                    const SizedBox(height: 100,),
                  ]
              ),
            );
          }
          else{
              return const ScreenLoader();
          }
        }
      ),

      bottomNavigationBar: BottomNavigationBar (
        selectedItemColor: Colors.redAccent,
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
          if(index==1){
            // To be Included to add Favorites Page
          }
        },
      ),
    );
  }
}
