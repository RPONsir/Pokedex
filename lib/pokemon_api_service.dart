import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonApiService {
  fetchPokemonList({required String url}) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List<dynamic>;
      return results;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  fetchPokemonData({required String url}) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['types'];
      //print(results);
      return results;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}



