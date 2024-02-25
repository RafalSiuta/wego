import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';

import '../../providers/welcome_provider/welcome_provider.dart';
import '../../utils/dimensions/size_info.dart';
import 'date_header.dart';

class SliverDateHeader extends SliverPersistentHeaderDelegate {

  SliverDateHeader({this.minHeight = 75,this.maxHeight = 80,
    this.fontSize = 15});

  final double? minHeight;
  final double? maxHeight;
  final double fontSize;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var titleSize = SizeInfo.headerTitleSize;
    var subtitleSize = SizeInfo.headerSubtitleSize;
    var menuTop = SizeInfo.menuTopMargin;
    var edgePadding = SizeInfo.edgePadding;
    return Consumer<WelcomeProvider>(
      builder: (context, homeProvider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: blur(shrinkOffset), sigmaY: blur(shrinkOffset)),
                child: Padding(
                  padding:  EdgeInsets.only(
                      top: menuTop, right: 12.0, left: edgePadding),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: PlayAnimationBuilder<Offset>(
                      tween: Tween<Offset>(
                          begin: const Offset(-20.0, 0), end: Offset.zero),
                      duration: const Duration(milliseconds: 300),
                      delay: const Duration(milliseconds: 100),
                      curve: Curves.easeOut,
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: value,
                          child: RichText(
                            text: TextSpan(
                                text: '${homeProvider.weekday}\n',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(fontSize: titleSize),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '${homeProvider.date}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(fontSize: subtitleSize),
                                  )
                                ]),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
                padding: EdgeInsets.all(edgePadding),
                alignment: Alignment.centerRight,
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).textTheme.headlineLarge!.color,
                ))
          ],
        );
      },
    );

    // ClipRRect(
    //   child: BackdropFilter(
    //     filter: ImageFilter.blur(
    //         sigmaX: blur(shrinkOffset), sigmaY: blur(shrinkOffset)),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         const DateHeader(),
    //         IconButton(
    //             padding: EdgeInsets.all(edgePadding),
    //             alignment: Alignment.centerRight,
    //             onPressed: (){
    //               Navigator.pop(context);
    //             },
    //             icon: Icon(
    //               Icons.close,
    //               color: Theme.of(context).textTheme.headlineLarge!.color,
    //             ))
    //       ],
    //     ),
    //   ),
    // );

  }

  double blur(double shrinkOffset) {
    return 0.0 + math.min(5.0, shrinkOffset);
  }

  @override
  bool shouldRebuild(SliverDateHeader oldDelegate) {
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
