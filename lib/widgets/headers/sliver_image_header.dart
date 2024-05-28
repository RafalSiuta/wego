
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/rendering.dart';
import '../../model/calculation_model/calculation_model.dart';
import '../../model/color/color_switch.dart';
import '../../utils/dimensions/size_info.dart';
import '../../utils/internationalization/app_localizations.dart';
import 'date_header.dart';

class SliverImageHeader extends SliverPersistentHeaderDelegate {

  SliverImageHeader({this.minHeight = 180,this.maxHeight = 200,
    required this.data, required this.heroTag});

  final double? minHeight;
  final double? maxHeight;
  final CalculationModel? data;
  final String? heroTag;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var edgePadding = SizeInfo.leftEdgePadding;
    var titleSize = SizeInfo.headerTitleSize;
    var subtitleSize = SizeInfo.headerSubtitleSize;
    var cardBcgColor  = ColorSwitch(category: data!.category);
    var symbolSize = SizeInfo.iconSize;
    cardBcgColor.getColor(context);
    
    //print('MAX XTENT: ${maxHeight} / ${shrinkOffset * 0.1}');
    return Container(
      margin: EdgeInsets.only(top: topSpace(shrinkOffset)),
     // color: cardBcgColor.bcgColor!.withOpacity(opacity(shrinkOffset)),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Transform.translate(
            offset: Offset(0, -20),
            child: Container(
             // height: 210,
              width: MediaQuery.of(context).size.width,
              color: cardBcgColor.bcgColor!.withOpacity(opacity(shrinkOffset)),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 120,
            margin: EdgeInsets.symmetric(horizontal: edgePadding / 2),
            padding: EdgeInsets.only(left: edgePadding, right: edgePadding, top: edgePadding),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),

            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${data!.shortTitle}',style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: titleSize,height: 1.5,),),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(10)),
                //       color: cardBcgColor.bcgColor
                //   ),
                //   child:
                //
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       Text('${data!.shortTitle}',style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: titleSize,height: 1.5,),),
                //       Padding(
                //         padding: const EdgeInsets.only(left: 8.0),
                //         child: Icon(data!.symbol, size: symbolSize + 2,color: Theme.of(context).textTheme.headlineLarge!.color,),
                //       ),
                //
                //       // RichText(
                //       //     overflow: TextOverflow.ellipsis,
                //       //     textAlign: TextAlign.left,
                //       //     maxLines: 3,
                //       //
                //       //     text: TextSpan(
                //       //         text: '${data!.shortTitle}\n',
                //       //         style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: titleSize,height: 1.5),
                //       //         children: <TextSpan>[
                //       //           // TextSpan(
                //       //           //   text: AppLocalizations.of(context)!.translate(data!.title!),
                //       //           //   style: Theme.of(context).textTheme.headlineLarge!.copyWith( fontSize: subtitleSize),
                //       //           // )
                //       //         ]
                //       //     )),
                //     ],
                //   ),
                // ),
                RichText(text: TextSpan(
                    text: AppLocalizations.of(context)!.translate(data!.title!),
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(height: 1.5, fontSize: subtitleSize),
                    children: <TextSpan>[
                      TextSpan(
                        text: data!.value != null ? '\n${data!.value!.toStringAsFixed(2)} ': "\n",//'\n${data!.value!.toStringAsFixed(2)} ',
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: data!.infoColor, fontSize: subtitleSize),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.translate(data!.unit!),
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: data!.infoColor,fontSize: subtitleSize),
                      )
                    ]),),
                Divider( )
              ],

            ),
          ),
          Transform.translate(
            offset:  Offset(0, transY(shrinkOffset)),
            child: Hero(
              tag: heroTag ?? '',
              child: Image(
                  width: MediaQuery.of(context).size.width ,
                  height: MediaQuery.of(context).size.width ,
                  fit: BoxFit.contain,
                  alignment: Alignment.topRight,
                  image: AssetImage(data!.imagePath!)),
            ),
          ),
          Transform.translate(
            offset:  Offset(0, transY(shrinkOffset)),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 8.0, ),
                padding: const EdgeInsets.all( 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(titleSize)),
                    color: cardBcgColor.patternColor
                ),
                child: Icon(data!.symbol, size: titleSize,color: Theme.of(context).colorScheme.secondary,),
              ),
            ),
          ),

        ],
      ),
    );
  }
  //import 'dart:math' as math;
  double opacity(double shrinkOffset){
    if(shrinkOffset > 39){
      return 0.0 + math.min(1.0, shrinkOffset);
    }else{
      return 0.0;
    }

  }
  double topSpace(double shrinkOffset){
    if(shrinkOffset > 10 ){
      return math.min(5.0, shrinkOffset);
    }else{
      return math.max(50.0, shrinkOffset);
    }

  }

  double transY(double shrinkOffset){
    if(shrinkOffset > 10){
      return 0.0 + math.max(5,-shrinkOffset);
    }else{
      return 0.0 + math.min(-90,shrinkOffset);
    }

  }

  double blur(double shrinkOffset) {
    return 0.0 + math.min(5.0, shrinkOffset);
  }

  @override
  bool shouldRebuild(SliverImageHeader oldDelegate) {
    return false;
  }

  @override
  double get minExtent => minHeight!;
  @override
  double get maxExtent => math.max(maxHeight!, minHeight!);

// @override
// FloatingHeaderSnapConfiguration get snapConfiguration => null;
//
// @override
// // TODO: implement showOnScreenConfiguration
// PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration =>
//     null;
//
// @override
// // TODO: implement stretchConfiguration
// OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
//
// @override
// // TODO: implement vsync
// TickerProvider get vsync => null;
}
