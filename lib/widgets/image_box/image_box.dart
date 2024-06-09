import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  const ImageBox({this.width = 100, this.height = 100, this.path = '',this.iconColor = Colors.grey, super.key});
  final double width, height;
  final String path;
  final Color iconColor;


  @override
  Widget build(BuildContext context) {
    return path != "" ?
    Image(
        width: MediaQuery.of(context).size.width ,
        height: MediaQuery.of(context).size.width ,
        fit: BoxFit.contain,
        alignment: Alignment.topCenter,
        image: AssetImage(path)) :
    Align(
        alignment: Alignment.topLeft,
        child: Icon(Icons.add_photo_alternate, size: 90, color: iconColor,));
  }
}
