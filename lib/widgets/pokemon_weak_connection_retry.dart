import 'package:flutter/material.dart';

class PokemonWeakConnectionRetry extends StatelessWidget{

  const PokemonWeakConnectionRetry({super.key});


  @override
  Widget build(BuildContext context){
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Please Try Again",
          maxLines: 2,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            letterSpacing: 2,
          ),
        ),
        SizedBox(width: 10,),
        //Image.asset('images/refreshIcon.jpeg', height: 50,),
      ],
    );
  }

}