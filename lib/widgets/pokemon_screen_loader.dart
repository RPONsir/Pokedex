import 'package:flutter/material.dart';

class ScreenLoader extends StatelessWidget{

  const ScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    const Duration(milliseconds: 2000);
    return Center(
      widthFactor: double.infinity,
      child: Image.asset('images/loader1.gif',
        alignment: Alignment.center,
        width: double.infinity,
        fit: BoxFit.fitHeight,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}