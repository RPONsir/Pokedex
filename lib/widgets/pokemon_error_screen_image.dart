import 'package:flutter/material.dart';

class ErrorImage extends StatelessWidget {
  final String imageUrl;

  const ErrorImage(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageUrl,
      fit: BoxFit.fill,
    );
  }
}
