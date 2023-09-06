import 'package:flutter/material.dart';
import 'package:pokemon_list/screens/pokemon_favourites_screen.dart';
import 'package:pokemon_list/screens/pokemon_list_screen.dart';
import 'package:pokemon_list/widgets/pokemon_error_screen_image.dart';
import 'package:pokemon_list/widgets/pokemon_text_title_with_shadow.dart';

class PokemonDetailsScreenError extends StatefulWidget{
  final dynamic pokemonName;
  const PokemonDetailsScreenError({Key? key, required this.pokemonName, }) : super(key: key);
  @override
  State<PokemonDetailsScreenError> createState() => _PokemonDetailsScreenError();
}

class _PokemonDetailsScreenError extends State<PokemonDetailsScreenError> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 10,
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new), onPressed: () {
          Navigator.pop(context);
        },),
        title:
        const TitleWithShadow('Poke-Error', 40),
      ),
      body:
      Center(
          child: ListView(
              children: const [
                ErrorImage('images/errorPsyduckOut.jpeg'),
                SizedBox(
                    height: 70
                ),
                ErrorImage('images/whosThatPokemon.png'),
              ]
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