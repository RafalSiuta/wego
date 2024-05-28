import 'dart:ui';

import 'package:flutter/material.dart';

class ChartBlurBox extends StatelessWidget {
  const ChartBlurBox({required this.child, required this.borderRadiusAll, this.marginValue = 8.0, this.bottomPadding = 5.0, this.topPadding = 10.0, super.key});
  final Widget child;
  final double marginValue, topPadding, bottomPadding, borderRadiusAll;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(borderRadiusAll)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: marginValue),
          padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(borderRadiusAll)),
            color: Colors.transparent,//Theme.of(context).colorScheme.background.withOpacity(0.2),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/3.7,

          child: child
        ),
      ),
    );
  }
}
