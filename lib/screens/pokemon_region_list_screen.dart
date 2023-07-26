import 'package:flutter/material.dart';
import 'package:pokemon_list/screens/pokemon_list_screen.dart';
import 'package:pokemon_list/widgets/build_pokemon_grid.dart';
import 'package:pokemon_list/widgets/build_pokemon_searcher.dart';
import 'package:pokemon_list/widgets/pokemon_text_title_with_shadow.dart';

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

  @override
  void initState() {
    super.initState();
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildPokemonGrid(widget.regionPokemonList, widget.addValue),
          ],
        ),
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