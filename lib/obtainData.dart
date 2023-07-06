import 'pokemon_api_service.dart';



class ObtainData{

  final PokemonApiService apiService = PokemonApiService();


  Future<dynamic> fetchPokemonData(int index) async {
    try {
      final pokemonData = await apiService.fetchPokemonData(url: 'https://pokeapi.co/api/v2/pokemon/$index');
      return pokemonData;
    } catch (e) {
      // Handle error
      print('Failed to fetch Pokemon list: $e');
    }
  }

}