import 'package:flutter/material.dart';

class PokemonWeakConnectionImage extends StatelessWidget {
  const PokemonWeakConnectionImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50,
        ),
        Image.asset(
          'images/loaderrorImage.gif',
          height: 300,
        ),
        const Text(
          "No internet Connection Detected",
          maxLines: 2,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
