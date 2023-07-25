import 'package:flutter/material.dart';

class InternetErrorMessage extends StatelessWidget{

  const InternetErrorMessage({super.key});

  @override
  Widget build(BuildContext context){
    return const Center(
      child:Text("No internet Connection Detected",
        maxLines: 2,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          letterSpacing: 2,
        ),),
    );
  }

}