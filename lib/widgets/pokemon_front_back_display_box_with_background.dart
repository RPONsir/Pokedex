import 'package:flutter/material.dart';
import 'package:pokemon_list/widgets/pokemon_gif.dart';

// ignore: must_be_immutable
class PokemonGifVisualWithBackground extends StatefulWidget{

  bool imageFrontDisplayed;
  final List types;
  final String imageUrl;
  final String imageUrl2;
  final double boxWidth;
  final double boxHeight;
  final double edgeSpacing;

  PokemonGifVisualWithBackground({Key? key, required this.imageFrontDisplayed, required this.types, required this.imageUrl, required this.imageUrl2, required this.boxWidth, required this.boxHeight, required this.edgeSpacing}) : super(key: key);

  @override
  State<PokemonGifVisualWithBackground> createState() => _PokemonGifVisualWithBackground();
}

class _PokemonGifVisualWithBackground extends State<PokemonGifVisualWithBackground>{

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () => {
        if(widget.imageFrontDisplayed == true){
          setState(() {
            widget.imageFrontDisplayed = false;
          }),
        }
        else{
          setState(() {
            widget.imageFrontDisplayed = true;
          }),
        }
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(widget.edgeSpacing),
        width: widget.boxWidth,
        height: widget.boxHeight,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children:[
            Image.asset(
              'images/background${widget.types[0]}.jpeg',
              width:(widget.boxWidth-40),
              height:(widget.boxHeight-25),
              fit: BoxFit.fill,
            ),
            PokemonGif(
              widget.imageUrl,
              widget.imageUrl2,
              (widget.boxWidth-20),
              (widget.boxHeight-40),
              widget.imageFrontDisplayed,
            ),
          ],
        ),
      ),
    );
  }
}