import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:wego/utils/extensions/string_extension.dart';
import 'package:flutter/rendering.dart';

import '../../utils/internationalization/app_localizations.dart';

class LargeSliverHeader extends SliverPersistentHeaderDelegate {

  LargeSliverHeader({this.minHeight = 50,this.maxHeight = 60,
    this.padding = const EdgeInsets.only(left:12.0, right: 12.0, top: 16.0, bottom: 16.0),
    this.margin = const EdgeInsets.only(left:12.0, right: 12.0, top: 16.0, bottom: 16.0),
    this.fontSize = 15,required this.title, this.isInfoVisible = true, this.isBcgTransparent = true});

  final double? minHeight;
  final double? maxHeight;
  final String? title;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double fontSize;
  final bool isInfoVisible;
  final bool isBcgTransparent;


  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: margin,
        padding: padding,
        height: maxHeight,
        color: isBcgTransparent ? Colors.transparent : Theme.of(context).colorScheme.background,
        child: ClipRRect(
          //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0)),
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: blur(shrinkOffset), sigmaY: blur(shrinkOffset)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  //title!.capitalizeFirstLetter(),
                   AppLocalizations.of(context)!.translate(title!).capitalizeFirstLetter(),
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: fontSize ),
                ),
                Visibility(
                  visible: isInfoVisible,
                  child: IconButton(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.info_outline),
                    onPressed: (){},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double blur(double shrinkOffset) {
    return 0.0 + math.min(5.0, shrinkOffset);
  }

  @override
  bool shouldRebuild(LargeSliverHeader oldDelegate) {
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