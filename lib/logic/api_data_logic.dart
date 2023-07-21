class TypesLogic{
  statsData(data){
    final List stats = [];
    for (int i = 0; i < data.length; i++) {
      final data1 = data[i];
      final statsToAdd = data1['base_stat'];
      stats.add(statsToAdd);
    }
    return stats;
  }
  typesData(data){
    final List types = [];
    for (int i = 0; i < data.length; i++) {
      final data1 = data[i];
      final data2 = data1["type"];
      final data3 = data2["name"];
      types.add(data3);
    }
    return types;
  }
  textToColor(String type){
    String color;
    if(type=='normal'){
      color = 'lime';
      return color;
    }
    else if(type=='fire'){
      color = 'purple';
      return color;
    }
    else if(type=='fighting'){
      color = 'red';
      return color;
    }
    else if(type=='water'){
      color = 'blue';
      return color;
    }
    else if(type=='flying'){
      color = 'purple';
      return color;
    }
    else if(type=='grass'){
      color = 'green';
      return color;
    }
    else if(type=='poison'){
      color = 'purple';
      return color;
    }
    else if(type=='electric'){
      color = 'yellow';
      return color;
    }
    else if(type=='ground'){
      color = 'yellow';
      return color;
    }
    else if(type=='psychic'){
      color = 'pink';
      return color;
    }
    else if(type=='rock'){
      color = 'lime';
      return color;
    }
    else if(type=='ice'){
      color = 'cyan';
      return color;
    }
    else if(type=='bug'){
      color = 'green';
      return color;
    }
    else if(type=='dragon'){
      color = 'purple';
      return color;
    }
    else if(type=='ghost'){
      color = 'purple';
      return color;
    }
    else if(type=='dark'){
      color = 'browm';
      return color;
    }
    else if(type=='steel'){
      color = 'gray';
      return color;
    }
    else if(type=='fairy'){
      color = 'pink';
      return color;
    }
  }
}