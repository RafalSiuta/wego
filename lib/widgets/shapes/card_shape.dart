import 'dart:ui';
import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class CardShape extends CustomClipper<Path> {


@override
Path getClip(Size size) {

  double width = size.width;

  Path path = Path();
  path.moveTo(width *0.9166533,size.height*0.9988014);
  path.cubicTo(width *0.9387567,size.height*0.9988014,width *0.9599533,size.height*0.9927854,width *0.9755833,size.height*0.9820799);
  path.cubicTo(width *0.9912100,size.height*0.9713744,width *0.9999900,size.height*0.9568539,width *0.9999867,size.height*0.9417146);
  path.cubicTo(width *0.9999433,size.height*0.7734498,width *0.9998167,size.height*0.2789384,width *0.9997667,size.height*0.08214840);
  path.cubicTo(width *0.9997633,size.height*0.06345434,width *0.9863900,size.height*0.04594521,width *0.9639700,size.height*0.03528082);
  path.cubicTo(width *0.9415533,size.height*0.02461416,width *0.9129300,size.height*0.02214612,width *0.8873500,size.height*0.02867123);
  path.cubicTo(width *0.6727467,size.height*0.08341324,width *0.2119667,size.height*0.2009521,width *0.05425000,size.height*0.2411826);
  path.cubicTo(width *0.02163333,size.height*0.2495046,width *1.184238e-16,size.height*0.2708311,width *1.184238e-16,size.height*0.2946712);
  path.cubicTo(width *1.184238e-16,size.height*0.4182785,width *1.184238e-16,size.height*0.7969703,width *1.184238e-16,size.height*0.9417237);
  path.cubicTo(width *1.184238e-16,size.height*0.9568607,width *0.008780000,size.height*0.9713790,width *0.02440667,size.height*0.9820845);
  path.cubicTo(width *0.04003667,size.height*0.9927877,width *0.06123333,size.height*0.9988014,width *0.08333333,size.height*0.9988014);
  path.cubicTo(width *0.2716600,size.height*0.9988014,width *0.7283100,size.height*0.9988014,width *0.9166533,size.height*0.9988014);
  path.close();





// Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
// paint_0_fill.color = Color(0xff000000).withOpacity(1.0);
return path;
//canvas.drawPath(path,paint_0_fill);

}

@override
bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
