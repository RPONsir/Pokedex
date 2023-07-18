import 'package:flutter/material.dart';

class PokemonGif extends StatelessWidget{

  final String imageUrl;
  final String imageUrl2;
  final double width;
  final double height;
  final bool frontImage;

  const PokemonGif(this.imageUrl, this.imageUrl2, this.width, this.height, this.frontImage, {super.key});

  @override
  Widget build(BuildContext context,) {
    final String imageDisplayed;
    if(frontImage==true){
      imageDisplayed = imageUrl;
    }
    else{
      imageDisplayed = imageUrl2;
    }
    return FadeInImage(
        width: width,
        height: height,
        placeholder: const AssetImage("images/pokeLoader.gif"), alignment: Alignment.bottomCenter,
        image: NetworkImage(imageDisplayed,),
    );
  }
}