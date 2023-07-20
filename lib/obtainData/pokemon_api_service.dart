import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonApiService {

  fetchPokemonData({required String url, required String characteristics}) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data2 = jsonDecode(response.body);
      final result = data2[characteristics];
      return result;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}



