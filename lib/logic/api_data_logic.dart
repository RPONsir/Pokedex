class PokemonDataFetchLogic{
  // Obtains data 1 layer of jsonFile
  dataFetchOneLayer(data, String layer1){
    final List obtainedData = [];
    for (int i = 0; i < data.length; i++) {
      final data1 = data[i];
      final statsToAdd = data1[layer1];
      obtainedData.add(statsToAdd);
    }
    return obtainedData;
  }
  // Obtains data 2 layer of jsonFile
  dataFetchTwoLayers(data , String layer1, String layer2){
    final List obtainedData = [];
    for (int i = 0; i < data.length; i++) {
      final data1 = data[i];
      final data2 = data1[layer1];
      final data3 = data2[layer2];
      obtainedData.add(data3.toUpperCase());
    }
    return obtainedData;
  }
  // Obtains data for second evolution(s) that is/are available and id is not above 721 limit
  dataFetchSecondEvolutionIsAvailable(data , String layer1, String layer2, String pokemonName){
    final List obtainedData = [];
    // Obtain length of available Pokemon 2nd Evolution
    List pokemonsUrl = dataFetchTwoLayers(data,'species',"url");
    int pokemonQuantity = pokemonsUrl.length;
    // Navigate for each available Pokemon
    for(int i = 0; i < pokemonQuantity; i++) {
      // E.g https://pokeapi.co/api/v2/pokemon-species/
      // Remove first 42 char and Remove last char "/" from URL to obtain a number
      String obtainedUrl = pokemonsUrl[i].toString().substring(42, (pokemonsUrl[i].length-1));
      int pokemonId = int.parse(obtainedUrl);
      // Filter Pokemon up to the Limit 721
      if(pokemonId>721){
        //Do Nothing
      }
      // Add Pokemon Name to list
      else{
        final data1 = data[i];
        final data2 = data1[layer1];
        final data3 = data2[layer2];
        obtainedData.add(data3);
      }
    }
    return obtainedData;

  }
  // Obtains data for third evolution(s) that is/are available and id is not above 721 limit
  dataFetchThirdEvolutionIsAvailable(data , String layer1, String layer2, String layer3){
    final List obtainedData = [];
    // Data found on the First Position
    final datalayer = data[0];
    // Obtain length of available Pokemon 3rd Evolution
    List pokemonsUrl = dataFetchTwoLayers(datalayer[layer1],'species',"url");
    int pokemonQuantity = pokemonsUrl.length;
    // Navigate for each available Pokemon
    for(int i = 0; i < pokemonQuantity; i++) {
      final data1 = data[0];
      final data2 = data1[layer1];
      // If theres no data - Return Information
      if((data2?.isEmpty ?? true)){
        return obtainedData;
      }
      else{
        // E.g https://pokeapi.co/api/v2/pokemon-species/
        // Remove first 42 char and Remove last char "/" from URL to obtain a number
        String obtainedUrl = pokemonsUrl[i].toString().substring(42, (pokemonsUrl[i].length-1));
        int pokemonId = int.parse(obtainedUrl);
        // Filter Pokemon up to the Limit 721
        if(pokemonId>721){
          //Do Nothing
        }
        // Add Pokemon Name to list
        else {
          final data3 = data2[i];
          final data4 = data3[layer2];
          final data5 = data4[layer3];
          obtainedData.add(data5);
        }
      }
    }
    return obtainedData;
  }
  // Function Check if the pokemon has Valid EvolutionsChain until the 6th Generation (721 pokemonList)
  dataFetchPokemonEvolution(data){
    bool hasPokemonEvolutionChain;
    List pokemonEvolutionChain=[];
    // If empty value comes in here - there are no evolution chain
    if(data["evolves_to"]?.isEmpty ?? true){
      hasPokemonEvolutionChain=false;
      pokemonEvolutionChain.add("No Evolution Chain");
      return[hasPokemonEvolutionChain, pokemonEvolutionChain, "No Evolution Chain"];
    }
    // If a value is found - a evolution chain is available
    else{
      List url = dataFetchTwoLayers(data['evolves_to'],'species',"url");
      // E.g https://pokeapi.co/api/v2/pokemon-species/
      // Remove first 42 char and Remove last char "/" from URL to obtain a number
      String obtainedUrl = url[0].toString().substring(42, (url[0].length-1));
      int pokemonId = int.parse(obtainedUrl);
      // Filter Pokemon up to the Limit 721
      if(pokemonId>721){
        hasPokemonEvolutionChain=false;
        pokemonEvolutionChain.add("No Evolution Chain");
        return[hasPokemonEvolutionChain, pokemonEvolutionChain, "No Evolution Chain"];
      }
      else{
        hasPokemonEvolutionChain=true;
        //Obtain First Pokemon Evolution
        var pokemonChain1 = data['species'];
        String pokemonName1 = pokemonChain1['name'];
        pokemonEvolutionChain.add([1, pokemonName1]);

        // Check and Add 2nd Evolution(s)
        List pokemonName2 = dataFetchSecondEvolutionIsAvailable(data['evolves_to'],'species',"name",pokemonName1);
        pokemonEvolutionChain.add([2,pokemonName2.join(', ').toString()]);

        // Check and Add 3rd Evolution(s) if available
        List pokemonName3 = dataFetchThirdEvolutionIsAvailable(data['evolves_to'],'evolves_to','species','name');
        if(pokemonName3.isEmpty){
          // as an empty value is coming do nothing
        }
        else{
            //Third evolution found, add to list
            pokemonEvolutionChain.add([3,pokemonName3.join(', ').toString()]);
        }
        return[hasPokemonEvolutionChain, pokemonEvolutionChain, "See Evolution Chain"];
      }
    }
  }
}