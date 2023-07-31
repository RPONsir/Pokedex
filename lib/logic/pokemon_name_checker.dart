class PokemonNameChecker {
  // Checks if the name has no more text after an "-" and removes it
  // For special pokemon name cases vs GIF URL - Name fas fixed to match Database
  nameCheckerGetImageURL(pokemon) {
    final pokemonName = pokemon;
    // Special Case Mr Mime
    if (pokemonName == ('mr-mime')) {
      const pokemonFinalName = 'mr-mime';
      const imageUrl = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados/mr._mime.gif';
      const imageUrl2 = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados-espalda/$pokemonFinalName.gif';
      return [pokemonFinalName, imageUrl, imageUrl2];
    }
    // Special Case Mime Jr
    if (pokemonName == ('mime-jr')) {
      const pokemonFinalName = 'mime-jr';
      const imageUrl = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados/mime_jr.gif';
      const imageUrl2 = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados-espalda/$pokemonFinalName.gif';
      return [pokemonFinalName, imageUrl, imageUrl2];
    }
    // Special case Nidoran male
    else if (pokemonName == ('nidoran-m')) {
      const pokemonFinalName = 'nidoran-m';
      const imageUrl = 'https://professorlotus.com/Sprites/Nidoran_M.gif';
      const imageUrl2 = 'https://professorlotus.com/Sprites/Nidoran_M.gif';
      return [pokemonFinalName, imageUrl, imageUrl2];
    }
    // Special case Nidoran female
    else if (pokemonName == ('nidoran-f')) {
      const pokemonFinalName = 'nidoran-f';
      const imageUrl = 'https://professorlotus.com/Sprites/Nidoran_F.gif';
      const imageUrl2 = 'https://professorlotus.com/Sprites/Nidoran_F.gif';
      return [pokemonFinalName, imageUrl, imageUrl2];
    }
    // Special case Ho-Oh that does not need to be removed the name after the "-"
    else if (pokemonName == ('ho-oh')) {
      const pokemonFinalName = 'ho-oh';
      const imageUrl = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados/$pokemonFinalName.gif';
      const imageUrl2 = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados-espalda/$pokemonFinalName.gif';
      return [pokemonFinalName, imageUrl, imageUrl2];
    }
    // Special case Porygon2 that does not need to be removed the name after the "-"
    else if (pokemonName == ('porygon2')) {
      const pokemonFinalName = 'porygon2';
      const imageUrl = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados/porygon2.gif';
      const imageUrl2 = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados-espalda/porygon2.gif';
      return [pokemonFinalName, imageUrl, imageUrl2];
    }
    // Special case Porygon-Z that does not need to be removed the name after the "-"
    else if (pokemonName == ('porygon-z')) {
      const pokemonFinalName = 'porygon-z';
      const imageUrl = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados/$pokemonFinalName.gif';
      const imageUrl2 = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados-espalda/$pokemonFinalName.gif';
      return [pokemonFinalName, imageUrl, imageUrl2];
    }
    else {
      final pokemonLine = pokemonName.indexOf("-");
      // If therese an index of "-" remove string since the character
      if (pokemonLine > 0) {
        final pokemonFinalName = pokemonName.substring(0, pokemonLine);
        final imageUrl = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados/$pokemonFinalName.gif';
        final imageUrl2 = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados-espalda/$pokemonFinalName.gif';
        return [pokemonFinalName, imageUrl, imageUrl2];
      }
      // No "-" was found - name remains the same
      else{
        final pokemonFinalName = pokemonName;
        final imageUrl = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados/$pokemonFinalName.gif';
        final imageUrl2 = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados-espalda/$pokemonFinalName.gif';
        return [pokemonFinalName, imageUrl, imageUrl2];
      }
    }
  }
  // Compares Name to si if the Searched Pokemon matches to any on the Pokemon DB
  pokemonListComparison(List<dynamic> allPokemonList, String pokemonName, int initPokemonValue, int finalPokemonValue){
    bool isFound=false;
    int currentPokemonId=0;
    // Search if the received name matches with the Api Pokemon List name
    for (int i = initPokemonValue; i < finalPokemonValue; i++) {
      // Retrieve Pokemon name as String from API
      final pokemon = allPokemonList[i];
      String pokemonNameOnList= pokemon['name'].toString();
      // Check Name to match the Current Input and Displayed Name on the ListView
      final newName = nameCheckerGetImageURL(pokemonNameOnList);
      pokemonNameOnList = newName[0];
      // Compare - if matches return True
      if(pokemonName==pokemonNameOnList){
        isFound = true;
        currentPokemonId = i+1;
        return [isFound, currentPokemonId];
      }
      // If no match found after navigating all pokemon names on list, return False
    }return [isFound, currentPokemonId];
  }
}