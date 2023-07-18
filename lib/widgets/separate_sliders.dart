import 'package:flutter/material.dart';

class SeparatingSpaceSliders extends StatelessWidget{

  String sliderTitle;

  SeparatingSpaceSliders(this.sliderTitle,  {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55,
        width: double.infinity,
        color: Colors.black,
        alignment: Alignment.center,
        child:
        Text(
          sliderTitle, textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 34.0,
            fontWeight: FontWeight.w500,
            shadows: [
              Shadow(
                color: Colors.white.withOpacity(0.7),
                offset: const Offset(2, 2),
                blurRadius: 3,
              ),
            ],
          ),
        )
      //const Image(image: AssetImage('images/pokeLoader.gif'),repeat: ImageRepeat.repeat,),
    );
  }
}