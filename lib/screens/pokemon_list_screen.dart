import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokemon_list/widgets/build_pokemon_searcher.dart';
import 'package:pokemon_list/widgets/build_pokemon_slider.dart';
import 'package:pokemon_list/obtainData/pokemon_api_service.dart';
import 'package:pokemon_list/widgets/error_message_no_internet.dart';
import 'package:pokemon_list/widgets/pokemon_screen_loader.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});
  @override
  PokemonListScreenState createState() => PokemonListScreenState();
}

class PokemonListScreenState extends State<PokemonListScreen> {

  final PokemonApiService apiService = PokemonApiService();

  late Future<dynamic> pokemonFirstData;
  late bool isDeviceConnected = false;
  late String isAlertSet = 'unknown';

  List<dynamic> allPokemonList = [];
  List<dynamic> pokemonList1 = [];
  List<dynamic> pokemonList2 = [];
  List<dynamic> pokemonList3 = [];
  List<dynamic> pokemonList4 = [];
  List<dynamic> pokemonList5 = [];
  List<dynamic> pokemonList6 = [];

  var listener;

  @override
  void initState() {
    super.initState();
    pokemonFirstData = fetchPokemonData();
    internetCheckingStatus();
  }

  void internetCheckingStatus() async {
    // Simple check to see if we have internet
    print("The statement 'this machine is connected to the Internet' is: ");
    print(await InternetConnectionChecker().hasConnection);
    print("Current status: ${await InternetConnectionChecker().connectionStatus}");
    listener = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          print('Data connection is available.');
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          break;
        case InternetConnectionStatus.disconnected:
          print('You are disconnected from the internet.');
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                padding: EdgeInsets.all(10),
                content: Text('No Internet Connection Detected',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                showCloseIcon: true,
                backgroundColor: Colors.blueGrey,
                closeIconColor: Colors.white,
                duration: Duration(hours: 1),
              )
          );
          break;
      }
    });
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
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
        future: pokemonFirstData,
        builder: (context, snapshot){
          if((snapshot.connectionState == ConnectionState.done)&&(isAlertSet=='false')){
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
                  Container(height: 40, width: double.infinity,color: Colors.black,
                  ),
                ],
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
