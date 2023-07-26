import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokemon_list/screens/pokemon_list_screen.dart';
import 'package:pokemon_list/widgets/error_message_no_internet.dart';
import 'package:pokemon_list/widgets/pokemon_error_screen_image.dart';
import 'package:pokemon_list/widgets/pokemon_text_title_with_shadow.dart';
import 'package:pokemon_list/widgets/pokemon_screen_loader.dart';

class PokemonDetailsScreenError extends StatefulWidget{
  final dynamic pokemonName;
  const PokemonDetailsScreenError({Key? key, required this.pokemonName, }) : super(key: key);
  @override
  State<PokemonDetailsScreenError> createState() => _PokemonDetailsScreenError();
}

class _PokemonDetailsScreenError extends State<PokemonDetailsScreenError> {

  late bool isDeviceConnected;
  late String isAlertSet = 'true';

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
        elevation: 10,
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title:
        const TitleWithShadow('Poke-Error', 40),
      ),
      body: FutureBuilder(
        builder: (context, snapshot){
          if(isAlertSet=='false'){
            return Center(
              child: ListView(
                  children: const [
                    ErrorImage('images/errorPsyduckOut.jpeg'),
                    SizedBox(
                        height: 70
                    ),
                    ErrorImage('images/whosThatPokemon.png'),
                  ]
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