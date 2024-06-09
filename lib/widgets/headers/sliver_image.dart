
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/rendering.dart';
import '../../model/calculation_model/calculation_model.dart';
import '../../model/color/color_switch.dart';
import '../../utils/dimensions/size_info.dart';
import '../../utils/internationalization/app_localizations.dart';
import '../image_box/image_box.dart';
import '../shapes/card_large_pattern.dart';

class SliverImage extends SliverPersistentHeaderDelegate {

  SliverImage({this.minHeight = 180,this.maxHeight = 250,
    required this.imagePath, required this.heroTag, required this.category});

  final double? minHeight;
  final double? maxHeight;
  final String imagePath;
  final String? category;
  final String? heroTag;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var edgePadding = SizeInfo.leftEdgePadding;
    var titleSize = SizeInfo.headerTitleSize;
    var subtitleSize = SizeInfo.headerSubtitleSize;
    var cardBcgColor  = ColorSwitch(category: category);
    cardBcgColor.getColor(context);
    //print('MAX XTENT: ${maxHeight} / ${shrinkOffset * 0.1}');
    return Container(
      color: cardBcgColor.bcgColor!.withOpacity(opacity(shrinkOffset)),
      child: Stack(
        alignment: Alignment.topRight,
        children: [

          CustomPaint(
            size: Size(MediaQuery.of(context).size.width/ 2.5, MediaQuery.of(context).size.height - shrinkOffset),
            painter: CardLargePattern(color: cardBcgColor.patternColor!.withOpacity(opacity(shrinkOffset)),),

          ),
          Transform.translate(
            offset:  Offset(transX(shrinkOffset), transY(shrinkOffset)),
            child: Hero(
              tag: heroTag ?? '',
              child: ImageBox(
                  width: MediaQuery.of(context).size.width ,
                  height: MediaQuery.of(context).size.width ,
                  path: imagePath,
                  iconColor: cardBcgColor.patternColor!,
              ),
            ),
          ),
        ],
      ),
    );


  }

  double opacity(double shrinkOffset){
    if(shrinkOffset > 39){
      return 0.0 + math.min(1.0, shrinkOffset);
    }else{
      return 0.0;
    }

  }

  double transY(double shrinkOffset){
    if(shrinkOffset > 10){
      return 0.0 + math.max(25,-shrinkOffset);
    }else{
      return 0.0 + math.min(0,shrinkOffset);
    }

  }

  double transX(double shrinkOffset){
    if(shrinkOffset > 10){
      return 0.0 + math.max(60,-shrinkOffset);
    }else{
      return 0.0 + math.min(20,shrinkOffset);
    }

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
