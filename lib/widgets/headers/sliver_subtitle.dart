import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/rendering.dart';
import 'package:wego/utils/extensions/string_extension.dart';
import '../../model/calculation_model/calculation_model.dart';
import '../../model/color/color_switch.dart';
import '../../utils/dimensions/size_info.dart';
import '../../utils/internationalization/app_localizations.dart';

class SliverSubtitle extends SliverPersistentHeaderDelegate {

  SliverSubtitle({this.minHeight = 180,this.maxHeight = 200,this.title, this.subtitle, this.isImageLeft = false, this.imagePath});

  final double? minHeight;
  final double? maxHeight;
  final String? title;
  final String? subtitle;
  final bool isImageLeft;
  final String? imagePath;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var edgePadding = SizeInfo.leftEdgePadding;
    var subtitleSize = SizeInfo.headerSubtitleSize;
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: edgePadding / 2),
          padding: EdgeInsets.only(left: edgePadding, right: edgePadding,),
          decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,//isImageLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
            crossAxisAlignment: isImageLeft ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              RichText(
                  overflow: TextOverflow.ellipsis,
                  textAlign: isImageLeft ? TextAlign.right : TextAlign.left,
                  maxLines: 4,
                  text: TextSpan(
                      text: '${AppLocalizations.of(context)!.translate(title!).capitalizeFirstLetter()}\n',
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: subtitleSize,height: 1.5),
                      children: <TextSpan>[
                        TextSpan(
                          text: AppLocalizations.of(context)!.translate(subtitle!).capitalizeFirstLetter(),
                        )
                      ]
                  )),
            // const Divider( ),
            ],

          ),
        ),
        Align(
          alignment: isImageLeft ? Alignment.centerLeft : Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: isImageLeft ? 0 : edgePadding, left: isImageLeft ? edgePadding : 0 ),
            child: Transform.translate(
              offset: Offset(0, 20),
              child: Image(
                  width: maxHeight! * 2 ,
                  height: maxHeight! * 2 ,
                  fit: BoxFit.contain,
                  alignment: isImageLeft ? Alignment.topLeft : Alignment.topRight,
                  image: AssetImage(imagePath!)),
            ),
          ),
        ),
      ],
    );
  }
  //import 'dart:math' as math;
  // double opacity(double shrinkOffset){
  //   if(shrinkOffset > 39){
  //     return 0.0 + math.min(1.0, shrinkOffset);
  //   }else{
  //     return 0.0;
  //   }
  //
  // }
  // double topSpace(double shrinkOffset){
  //   if(shrinkOffset > 10 ){
  //     return math.min(5.0, shrinkOffset);
  //   }else{
  //     return math.max(50.0, shrinkOffset);
  //   }
  //
  // }

  // double transY(double shrinkOffset){
  //   if(shrinkOffset > 10){
  //     return 0.0 + math.max(5,-shrinkOffset);
  //   }else{
  //     return 0.0 + math.min(-90,shrinkOffset);
  //   }
  //
  // }
  //
  // double blur(double shrinkOffset) {
  //   return 0.0 + math.min(5.0, shrinkOffset);
  // }

  @override
  bool shouldRebuild(SliverSubtitle oldDelegate) {
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
