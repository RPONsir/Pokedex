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
        placeholderFilterQuality: FilterQuality.high,
        filterQuality: FilterQuality.high,
        fadeInDuration: const Duration(seconds: 1),
        fadeInCurve: Curves.linear,
        imageErrorBuilder: (c, o, s) =>
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
            'images/pokeErrorIcon.png',
            height: height,
            width: width,
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
            ),
            Text('Unable to Load',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = Colors.red,
              ),
            ),
            const Text('Unable to Load',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            )
          ]
        ),
        placeholder: const AssetImage("images/pokeLoader.gif"), alignment: Alignment.bottomCenter,
        image: NetworkImage(imageDisplayed, scale: 0.9,
        ),
    );
  }
}