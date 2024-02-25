import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wego/utils/extensions/string_extension.dart';
import 'dart:math' as math;

import '../../utils/internationalization/app_localizations.dart';
class MediumSliverHeader extends SliverPersistentHeaderDelegate{

  MediumSliverHeader({this.fontSize, required this.title, this.minHeight = 40, this.maxHeight = 50,
    this.padding = const EdgeInsets.only(left:12.0, right: 12.0, top: 5.0, bottom: 5.0),});

  final double? fontSize;
  final String? title;
  final double? minHeight;
  final double? maxHeight;
  final EdgeInsets padding;


  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: blur(shrinkOffset), sigmaY: blur(shrinkOffset)),
        child: Container(
          width: MediaQuery.of(context).size.width - 24,
          height: maxExtent,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text( //title! ,
                AppLocalizations.of(context)!.translate(title!).capitalizeFirstLetter(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: fontSize ),),
              Visibility(
                visible: true,//isInfoVisible,
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
    );
  }

  double blur(double shrinkOffset) {
    return 0.0 + math.min(5.0, shrinkOffset);
  }

  @override
  bool shouldRebuild(MediumSliverHeader oldDelegate) {
    return false;
  }

  @override
  double get minExtent => minHeight!;
  @override
  double get maxExtent => math.max(maxHeight!, minHeight!);

}