import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:wego/utils/extensions/string_extension.dart';
import '../../model/calculation_model/calculation_model.dart';
import '../../model/color/color_switch.dart';
import '../../utils/dimensions/size_info.dart';
import '../../utils/internationalization/app_localizations.dart';

class SliverContainer extends SliverPersistentHeaderDelegate {

  SliverContainer({this.minHeight = 55,this.maxHeight = 60, required this.child, this.color, this.isRoundedCorners = true});

  final double? minHeight;
  final double? maxHeight;
  final Widget? child;
  final Color? color;
  final bool isRoundedCorners;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var edgePadding = SizeInfo.leftEdgePadding;

    return Align(
      alignment: Alignment.topCenter,
      child:
      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: edgePadding/2, ),
        padding: EdgeInsets.all(edgePadding),
        decoration: BoxDecoration(
          color: color,
          borderRadius: isRoundedCorners ? BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)) : BorderRadius.zero,
        ),
        child: child
        // TextField(
        //   maxLengthEnforcement:
        //   MaxLengthEnforcement.enforced,
        //   cursorWidth: 1,
        //   focusNode: titleNode,
        //   maxLines: 1,
        //   maxLength: maxTitleLength,
        //   onSubmitted: (val) {
        //     titleNode!.unfocus();
        //   },
        //   keyboardType: TextInputType.text,
        //   enabled: editEnable,
        //   onChanged: onChange,
        //   cursorColor: Theme.of(context).indicatorColor,
        //   controller: controller,
        //   autofocus: true,
        //   style: Theme.of(context)
        //       .textTheme.titleSmall!.copyWith(
        //       fontSize: titleFontSize,
        //       decoration: TextDecoration.none),
        //   textAlign: TextAlign.start,
        //   decoration: InputDecoration(
        //     helperText: AppLocalizations.of(context)!.translate('input_title').capitalizeFirstLetter(),
        //     helperStyle: Theme.of(context)
        //         .inputDecorationTheme
        //         .helperStyle!
        //         .copyWith(
        //         color: Theme.of(context).textTheme.titleSmall!.color,
        //         fontSize: helpTextFontSize),
        //   ),
        // ),
      ),
    );

  }


  @override
  bool shouldRebuild(SliverContainer oldDelegate) {
    return false;
  }

  @override
  double get minExtent => minHeight!;
  @override
  double get maxExtent => math.max(maxHeight!, minHeight!);

}
