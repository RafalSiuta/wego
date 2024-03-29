import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'dart:ui' as ui;

//Add this CustomPaint widget to the Widget Tree
// CustomPaint(
// size: Size(WIDTH, (WIDTH*1.4457831325301205).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
// painter: RPSCustomPainter(),
// )

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

    // Path path_0 = Path();
    // path_0.moveTo(0,size.height*1.787483);
    // path_0.lineTo(0,size.height*5.040943);
    // path_0.lineTo(size.width*3.448230,size.height*5.040897);
    // path_0.cubicTo(size.width*3.448230,size.height*5.040897,size.width*3.447724,size.height*1.862069,size.width*3.447529,size.height*0.7334713);
    // path_0.lineTo(0,size.height*1.787483);
    // path_0.close();





// Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
// paint_0_fill.color = Color(0xff000000).withOpacity(1.0);
    return path;
//canvas.drawPath(path,paint_0_fill);

  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

}