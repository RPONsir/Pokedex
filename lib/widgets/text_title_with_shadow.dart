import 'package:flutter/material.dart';

class TitleWithShadow extends StatelessWidget{
  final String title;
  final double fontSize;

  const TitleWithShadow(this.title, this.fontSize, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.yellow,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.7),
            offset: const Offset(3, 3),
            blurRadius: 5,
          ),
        ],
      ),
    );
  }
}