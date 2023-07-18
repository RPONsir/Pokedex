import 'pokemon_api_service.dart';

//unused Class
class PokemonListGeneration{

  List<dynamic> allPokemonList = [];
  List<dynamic> pokemonList1 = [];
  List<dynamic> pokemonList2 = [];
  List<dynamic> pokemonList3 = [];
  List<dynamic> pokemonList4 = [];
  List<dynamic> pokemonList5 = [];
  List<dynamic> pokemonList6 = [];
  // List<dynamic> pokemonList7 = [];
  // List<dynamic> pokemonList8 = [];

  final PokemonApiService apiService = PokemonApiService();

  Future fetchPokemonList() async {
    try {
      final pokemonData = await apiService.fetchPokemonList(url: 'https://pokeapi.co/api/v2/pokemon?limit=898');
      allPokemonList = pokemonData;
      pokemonList1 = allPokemonList.sublist(0, 151);
      pokemonList2 = allPokemonList.sublist(151, 251);
      pokemonList3 = allPokemonList.sublist(251, 386);
      pokemonList4 = allPokemonList.sublist(386, 493);
      pokemonList5 = allPokemonList.sublist(493, 649);
      pokemonList6 = allPokemonList.sublist(649, 721);
      // pokemonList7 = allPokemonList.sublist(721, 809);
      // pokemonList8 = allPokemonList.sublist(809, 898);
      return[pokemonList1,pokemonList2,pokemonList3,pokemonList4,pokemonList5,pokemonList6];
    } catch (e) {
      // Handle error
      //print('Failed to fetch Pokemon list: $e');
    }
  }
}