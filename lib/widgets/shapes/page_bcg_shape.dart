import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'dart:ui' as ui;


//Copy this CustomPainter code to the Bottom of the File
class PageBcgShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    double width = size.width;

    Path path = Path();
    path.moveTo(0,size.height*0.6706667);
    path.lineTo(0,0);
    path.lineTo(size.width*0.9975904,size.height*0.000008333333);
    path.cubicTo(size.width*0.9975904,size.height*0.000008333333,size.width*0.9974458,size.height*0.6552917,size.width*0.9973855,size.height*0.8879333);
    path.lineTo(0,size.height*0.6706667);
    path.close();
    return path;

  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

}
