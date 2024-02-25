import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/rendering.dart';
import '../../model/calculation_model/calculation_model.dart';
import '../../model/color/color_switch.dart';
import '../../utils/dimensions/size_info.dart';
import '../../utils/internationalization/app_localizations.dart';

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
    cardBcgColor.getColor(context);
    print('MAX XTENT: ${maxHeight} / ${shrinkOffset * 0.1}');
    double opacity = shrinkOffset > 100 ? 1.0 : 0;
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Transform.translate(
            offset:  Offset(0, -90),
            child: Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              color: cardBcgColor.bcgColor!.withOpacity(opacity),
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
                RichText(
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    maxLines: 3,

                    text: TextSpan(
                        text: '${data!.shortTitle}\n',
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: titleSize,height: 1.5),
                        children: <TextSpan>[
                          TextSpan(
                            text: AppLocalizations.of(context)!.translate(data!.title!),
                            style: Theme.of(context).textTheme.headlineLarge!.copyWith( fontSize: subtitleSize),
                          )
                        ]
                    )),
                RichText(text: TextSpan(
                    text: '${data!.value!.toStringAsFixed(2)} ',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: data!.infoColor,height: 1.5, fontSize: subtitleSize),
                    children: <TextSpan>[
                      TextSpan(
                        text: AppLocalizations.of(context)!.translate(data!.unit!),
                        // style: Theme.of(context).textTheme.headlineMedium!.copyWith( fontSize: descriptionFontSize),
                      )
                    ]),),
                Divider( )
              ],

            ),
          ),
          Transform.translate(
            offset:  Offset(0, -90),
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

        ],
      ),
    );
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
