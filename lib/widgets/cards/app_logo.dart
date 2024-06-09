import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({this.imgSize = 100, required this.imageName, super.key});
  final String imageName;
  final double imgSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: imgSize,
      height: imgSize,
      child: Image(
          alignment: Alignment.topRight,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.contain,
          image: AssetImage('images/$imageName.png')),
    );
  }
}
