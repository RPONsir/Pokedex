import 'package:flutter/material.dart';
import 'package:pokemon_list/pokemonDetailsScreen.dart';
import 'pokemon_api_service.dart';
import 'pokemonNameChecker.dart';
import 'pokemonDetailsScreenError.dart';

class PokemonListScreen extends StatefulWidget {
  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {

  final PokemonNameChecker pokemonChecker = PokemonNameChecker();
  final PokemonApiService apiService = PokemonApiService();

  //Listado total y subsecciones por regiones
  List<dynamic> allPokemonList = [];
  List<dynamic> pokemonList1 = [];
  List<dynamic> pokemonList2 = [];
  List<dynamic> pokemonList3 = [];
  List<dynamic> pokemonList4 = [];
  List<dynamic> pokemonList5 = [];
  List<dynamic> pokemonList6 = [];
  // List<dynamic> pokemonList7 = [];
  // List<dynamic> pokemonList8 = [];

  // editor objeto para manejar textfield
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPokemonList();
  }

  // Fetch data y creacion de las subsecciones basados en los limites segun ID por region
  Future<void> fetchPokemonList() async {
    try {
      final pokemonData = await apiService.fetchPokemonList(url: 'https://pokeapi.co/api/v2/pokemon?limit=898');
      setState(() {
        allPokemonList = pokemonData;
        pokemonList1 = allPokemonList.sublist(0, 151);
        pokemonList2 = allPokemonList.sublist(151, 251);
        pokemonList3 = allPokemonList.sublist(251, 386);
        pokemonList4 = allPokemonList.sublist(386, 493);
        pokemonList5 = allPokemonList.sublist(493, 649);
        pokemonList6 = allPokemonList.sublist(649, 721);
        // pokemonList7 = allPokemonList.sublist(721, 809);
        // pokemonList8 = allPokemonList.sublist(809, 898);
      });
    } catch (e) {
      // Handle error
      print('Failed to fetch Pokemon list: $e');
    }
  }

  // Navegador a Pagina de Pokemon Details
  void navigateToPokemonDetails(dynamic pokemon, dynamic imageUrl,) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PokemonDetailsScreen(pokemon: pokemon, imageUrl : imageUrl,),
      ),
    );
  }

  // Navegador a Pagina de Pokemon Details Error
  void navigateToPokemonDetailsError(dynamic pokemonName, ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PokemonDetailsScreenError(pokemonName: pokemonName,),
      ),
    );
  }

  @override
  // Pagina Principal Construccion
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/International_Pokémon_logo.svg/1200px-International_Pokémon_logo.svg.png',
          height: 66,
          fit: BoxFit.fitHeight,),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPokemonSlider('Kanto', pokemonList1, 1),
            _buildPokemonSlider('Johto', pokemonList2, 152),
            _buildPokemonSlider('Hoenn', pokemonList3, 252),
            _buildPokemonSlider('Sinnoh', pokemonList4, 387),
            _buildPokemonSlider('Teselia', pokemonList5, 494),
            _buildPokemonSlider('Kalos', pokemonList6, 650),
            // _buildPokemonSlider('Alola', pokemonList7, 722),
            // _buildPokemonSlider('Galar', pokemonList8, 810),
            _buildPokemonSearcher(),
          ],
        ),
      ),
    );
  }

  // TextField Buscador
  Widget _buildPokemonSearcher(){
    return Column(
      children: [
        Container(
          height: 100,
          width: double.infinity,
          color: Colors.white,
          alignment: Alignment.center,
          child:
            TextField(
              controller: _textEditingController,
              textAlign: TextAlign.center,
                maxLines: 1,
                maxLength: 15,
                keyboardType: TextInputType.streetAddress,
                keyboardAppearance: Brightness.dark,
                style: const TextStyle(color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    backgroundColor: Color.fromRGBO(255, 255, 255, 0)),
              onSubmitted: (value) {
                // Deseleccionar Keyboard
                FocusScope.of(context).unfocus();
                // Limpiar Text Textfield
                _textEditingController.clear();
                // Convertir Value a lowercase para hacer match con Listado Pokemons
                final searchText = value.toLowerCase();
                // Conversor de Nombres y obtencion de imagenes de Pokemons
                final pokemonFinalData = pokemonChecker.lineChecker(searchText);
                // Nombre en String
                final pokemonFinalName = pokemonFinalData[0];
                // URL Gif
                final imageUrl = pokemonFinalData[1];
                // Comparacion de Nombre con Lista de Pokemon
                final isFound = pokemonChecker.pokemonListComparison(allPokemonList, pokemonFinalName);
                  if(isFound==true){
                    // Coincide va a llevar al Pokemon Details
                    navigateToPokemonDetails(pokemonFinalName, imageUrl,);
                  }
                  else{
                    // NO Coincide va a llevar al Pokemon Details Error
                    navigateToPokemonDetailsError(pokemonFinalName,);
                  }
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, size: 40,),
                  hintText: 'Type a Pokemon Name',
                ),
            ),
        ),
      ],
    );
  }

  // Sliders horizontales por cada Region
  Widget _buildPokemonSlider(String sliderTitle, List<dynamic> pokemonList, int addValueList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // Separador con nombre de Region
      children: [
        Container(
          height: 55,
          width: double.infinity,
          color: Colors.black,
          alignment: Alignment.center,
          child:
            Text(
                sliderTitle, textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34.0,
                  fontWeight: FontWeight.w500,
                  shadows: [
                    Shadow(
                      color: Colors.white.withOpacity(0.7),
                      offset: const Offset(2, 2),
                      blurRadius: 3,
                    ),
                  ],
                ),
            )
          //const Image(image: AssetImage('images/pokeLoader.gif'),repeat: ImageRepeat.repeat,),
        ),

        // Generaxion recuadros con Imagen y Nombre del Slider
        Container(
          color: Colors.black,
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: pokemonList.length,
            itemBuilder: (context, index) {
              // Del API se pokemon que proviene con 2 valores
              final pokemon = pokemonList[index];
              // ID de POKEMON
              final pokemonId = index+addValueList;
              // Obtenemos el Nombre
              final pokemonName = pokemon['name'].toString();
              // Validamos el Nombre que este bien escrito y se edita de ser necesario
              final pokemonFinalData = pokemonChecker.lineChecker(pokemonName);
              // Obtenemos nombre final del pokemon
              final pokemonFinalName = pokemonFinalData[0];
              // Obtenemos URL del GIF
              final imageUrl = pokemonFinalData[1];
                // URL de GIFS
                //'https://www.pkparaiso.com/imagenes/xy/sprites/animados/$pokemonFinalName.gif';
                // final String imageUrl2 = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados-espalda/${pokemonFinalName[0]}.gif';
              return GestureDetector(
                // Al hacer click navegara al Pokemon Details
                onTap: () => navigateToPokemonDetails(pokemonFinalName, imageUrl,),
                child: Container(
                  width: 150,
                  // Espacio entre Containers de manera vertical
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      // Agregamos Asset para que carge de una sin problemas
                      Image.asset(
                        'images/listBackground.jpeg',
                        width: 150,
                        fit: BoxFit.fitWidth,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '#$pokemonId',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.7),
                                  offset: const Offset(1, 1),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Generacion animacion - mientras cargan GIFS
                          FadeInImage(
                            width: 150,
                            height: 110,
                            placeholder: const AssetImage("images/pokeLoader.gif"), alignment: Alignment.bottomCenter,
                            image: NetworkImage(imageUrl, ),
                          ),
                          // Espacio entre GIF y Nombre del Pokemon
                          const SizedBox(height: 3),
                          Text(
                            pokemonFinalName.toUpperCase(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.7),
                                  offset: const Offset(1, 1),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
