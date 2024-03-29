
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/rendering.dart';
import '../../model/calculation_model/calculation_model.dart';
import '../../model/color/color_switch.dart';
import '../../utils/dimensions/size_info.dart';
import '../../utils/internationalization/app_localizations.dart';

class SliverImage extends SliverPersistentHeaderDelegate {

  SliverImage({this.minHeight = 200,this.maxHeight = 250,
    required this.imagePath, required this.heroTag});

  final double? minHeight;
  final double? maxHeight;
  final String imagePath;
  //final CalculationModel? data;
  final String? heroTag;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var edgePadding = SizeInfo.leftEdgePadding;
    var titleSize = SizeInfo.headerTitleSize;
    var subtitleSize = SizeInfo.headerSubtitleSize;

    //print('MAX XTENT: ${maxHeight} / ${shrinkOffset * 0.1}');
    return Container(
      //margin: EdgeInsets.only(top: topSpace(shrinkOffset)),
      // color: cardBcgColor.bcgColor!.withOpacity(opacity(shrinkOffset)),
      child: Hero(
        tag: heroTag ?? '',
        child: Image(
            width: MediaQuery.of(context).size.width ,
            height: MediaQuery.of(context).size.width ,
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
            image: AssetImage(imagePath)),
      ),
    );
  }


  @override
  bool shouldRebuild(SliverImage oldDelegate) {
    return false;
  }

  @override
  double get minExtent => minHeight!;
  @override
  double get maxExtent => math.max(maxHeight!, minHeight!);

}
