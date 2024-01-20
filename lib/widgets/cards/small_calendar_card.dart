import 'package:flutter/material.dart';
import 'package:wego/utils/constans/prefs_keys.dart';
import '../shapes/card_shape.dart';

class SmallCalendarCard extends StatelessWidget {
  const SmallCalendarCard({this.imagePath = '', required this.title, required this.subtitle, required this.value, this.category, super.key});
  final String? imagePath;
  final String? title;
  final String? subtitle;
  final double? value;
  final String? category;

  @override
  Widget build(BuildContext context) {
    double fontSize = 12.0;
    double largeFontSize = 15.0;
    var bcgColor;
    if(category == workoutCategory){
      bcgColor = Color(0xFFF1BCD5);
    }else if(category == mealCategory){
      bcgColor = Color(0xFFEDF0A5);
    }else if(category == drinkCategory){
      bcgColor = Color(0xFFA0DCF1);
    }else if(category == supplementCategory){
      bcgColor = Color(0xFF85DA96);
    }else {
      bcgColor = Theme.of(context).colorScheme.surface;
    }
    return AspectRatio(
      aspectRatio: 4.5/6,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10),
            child: ClipPath(
              clipper: CardShape(),
              child: Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                  color: bcgColor,

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
