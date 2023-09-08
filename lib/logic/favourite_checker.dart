import '../obtainData/pokemon_db.dart';

class FavouritePokemonChecker {
  isPokemonFavourite(int pokemonId) async {
    bool pokemonIsFavorite = false;
    final favoritePokemonList =
        await DataBaseHelper.instance.getFavouritePokemon();
    for (int i = 0; i < favoritePokemonList.length; i++) {
      final currentPokemonId = favoritePokemonList[i];
      if (currentPokemonId['pokemonId'] == pokemonId) {
        pokemonIsFavorite = true;
      }
    }
    return pokemonIsFavorite;
  }
}
