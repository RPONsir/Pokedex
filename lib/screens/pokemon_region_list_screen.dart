import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokemon_list/screens/pokemon_list_screen.dart';
import 'package:pokemon_list/widgets/build_pokemon_grid.dart';
import 'package:pokemon_list/widgets/build_pokemon_searcher.dart';
import 'package:pokemon_list/widgets/error_message_no_internet.dart';
import 'package:pokemon_list/widgets/pokemon_text_title_with_shadow.dart';
import 'package:pokemon_list/widgets/pokemon_screen_loader.dart';

class PokemonRegionList extends StatefulWidget{

  final List<dynamic> allPokemonList;
  final List<dynamic> regionPokemonList;
  final String regionName;
  final int addValue;

  const PokemonRegionList({Key? key, required this.allPokemonList, required this.regionPokemonList, required this.regionName, required this.addValue}) : super(key: key);
  @override
  State<PokemonRegionList> createState() => _PokemonRegionList();

}

class _PokemonRegionList extends State<PokemonRegionList>{

  late bool isDeviceConnected;
  late String isAlertSet = 'unknown';
  final ScreenLoader screenLoader = const ScreenLoader();

  @override
  void initState() {
    super.initState();
    internetConnection();
  }

  Future<void> internetConnection() async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    if(isDeviceConnected == true){
      setState(() {
        isAlertSet = 'false';
        return;
      });
    }
    else{
      setState(() {
        isAlertSet = 'true';
        return;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.redAccent,
          elevation: 10,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleWithShadow(widget.regionName, 32),
            ],
          ),
          bottom: PreferredSize(
            preferredSize:
            const Size.fromHeight(80.0),
            child: BuildPokemonSearcher(context, widget.allPokemonList, widget.regionPokemonList.length, widget.addValue),
          ),
          actions: [
            Container(
              alignment: Alignment.centerRight,
              width: 70,
              child: Image.asset('images/Poke_Ball.webp', width:60, height:50,),
            ),
          ],
        ),
      body: FutureBuilder(
        builder: (context, snapshot){
          if(isAlertSet=='false'){
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildPokemonGrid(widget.regionPokemonList, widget.addValue),
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
          }
        },
      ),
    );
  }
}