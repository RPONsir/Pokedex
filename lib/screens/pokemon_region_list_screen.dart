import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokemon_list/screens/pokemon_favourites_screen.dart';
import 'package:pokemon_list/screens/pokemon_list_screen.dart';
import 'package:pokemon_list/widgets/build_pokemon_grid.dart';
import 'package:pokemon_list/widgets/build_pokemon_searcher.dart';
import 'package:pokemon_list/widgets/pokemon_text_title_with_shadow.dart';

import '../widgets/pokemon_screen_loader.dart';

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

  @override
  void initState() {
    dataChecker();
    super.initState();
  }

  Future<String> dataChecker()async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    if(isDeviceConnected ==true){
        isAlertSet = 'false';
        return isAlertSet;
    }
    else{
        isAlertSet = 'true';
        return isAlertSet;
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
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new), onPressed: () {
            Navigator.pop(context);
          },),
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
        future: Future.delayed(const Duration(seconds: 4)),
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
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50,),
                    Image.asset('images/loaderrorImage.gif', height: 300,),
                    const Text("No internet Connection Detected",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 30,),
                    GestureDetector(
                      onTap: () async =>  {
                        setState((){
                          isAlertSet = 'unknown';
                        }),
                        isDeviceConnected = await InternetConnectionChecker().hasConnection,
                        if(isDeviceConnected == true){
                            isAlertSet = 'false',
                        }
                        else{
                            isAlertSet = 'true',
                        },
                        Future.delayed(const Duration(seconds: 4)),(){
                          setState(() {
                            isAlertSet;
                          });
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Please Try Again",
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              letterSpacing: 2,
                            ),
                          ),
                          SizedBox(width: 10,),
                          //Image.asset('images/refreshIcon.jpeg', height: 50,),
                        ],
                      ),
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
            Navigator.push(
              context, MaterialPageRoute(
              builder: (context) =>
              const PokemonFavouriteListScreen(),
              maintainState: false,
            ),
            );
          }
        },
      ),
    );
  }
}