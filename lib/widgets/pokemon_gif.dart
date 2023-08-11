import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PokemonGif extends StatefulWidget{

  final String imageUrl;
  final String imageUrl2;
  final double width;
  final double height;
  final bool frontImage;
  final double scaleGif;

  const PokemonGif(this.imageUrl, this.imageUrl2, this.width, this.height, this.frontImage, this.scaleGif, {super.key});
  @override
  State<PokemonGif> createState() => _PokemonGif();
}

class _PokemonGif extends State<PokemonGif>{

  late String imageDisplayed;

  @override
  Widget build(BuildContext context,) {
    if(widget.frontImage==true){
      setState(() {
        imageDisplayed = widget.imageUrl;
      });
    }
    else{
      setState(() {
        imageDisplayed = widget.imageUrl2;
      });
    }
    return FadeInImage(
      width: widget.width,
      height: widget.height,
      placeholderFilterQuality: FilterQuality.high,
      filterQuality: FilterQuality.high,
      fadeInDuration: const Duration(seconds: 1),
      fadeInCurve: Curves.linear,
      image: CachedNetworkImageProvider(imageDisplayed, scale: widget.scaleGif,),
      placeholder: const AssetImage("images/pokeLoader.gif"), alignment: Alignment.bottomCenter,
      imageErrorBuilder: (c, o, s) =>
          Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'images/pokeErrorIcon.png',
                  height: widget.height,
                  width: widget.width,
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
    );
  }
}