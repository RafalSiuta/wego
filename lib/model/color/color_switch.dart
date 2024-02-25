import 'package:flutter/material.dart';
import 'package:wego/utils/constans/prefs_keys.dart';

class ColorSwitch{
  ColorSwitch({required this.category});
  String? category;
  Color? bcgColor;
  Color? patternColor;

  void getColor(context){

    if(category == workoutCategory){
      bcgColor = Color(0xFFFFCDD2);
      patternColor = Color(0xffFFBDC3);
    }else if(category == mealCategory){
      bcgColor = Color(0xFFF0F4C3);
      patternColor = Color(0xFFE7EF9F);
    }else if(category == drinkCategory){
      bcgColor = Color(0xFFB3E5FC);
      patternColor = Color(0xFF98DBFB);
    }else if(category == supplementCategory){
      bcgColor = Color(0xFFC8E6C9);
      patternColor = Color(0xFFB2DCB4);

    }else {
      bcgColor = Theme.of(context).colorScheme.surface;
      patternColor = Theme.of(context).colorScheme.surface;
    }
  }
}