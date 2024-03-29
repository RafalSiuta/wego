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

class SliverInputHeader extends SliverPersistentHeaderDelegate {

  SliverInputHeader({this.minHeight = 50,this.maxHeight = 60, required this.editText, this.titleNode, this.editEnable = false, required this.onChange,required this.controller});

  final VoidCallback? editText;
  final double? minHeight;
  final double? maxHeight;
  final FocusNode? titleNode;
  final bool? editEnable;
  final Function(String?) onChange;
  final TextEditingController controller;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var edgePadding = SizeInfo.leftEdgePadding;
    var titleFontSize = SizeInfo.taskCreatorTitle;
    var inputHeight = SizeInfo.searchBarHeight;
    var helpTextFontSize = SizeInfo.helpTextSize;
    int maxTitleLength = 20;
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: edgePadding/2, ),
        padding: EdgeInsets.all(edgePadding),
        decoration: BoxDecoration(
          color: Theme.of(context).indicatorColor,//Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),

        ),
        child: GestureDetector(
          onTap: editText,
          child: SizedBox(
            height: inputHeight,
            child: TextField(
              maxLengthEnforcement:
              MaxLengthEnforcement.enforced,
              cursorWidth: 1,
              focusNode: titleNode,
              maxLines: 1,
              maxLength: maxTitleLength,
              onSubmitted: (val) {
                titleNode!.unfocus();
              },
              keyboardType: TextInputType.text,
              enabled: editEnable,
              onChanged: onChange,
              cursorColor: Theme.of(context).indicatorColor,
              controller: controller,
              autofocus: true,
              style: Theme.of(context)
                  .textTheme.titleSmall!.copyWith(
                  fontSize: titleFontSize,
                  decoration: TextDecoration.none),
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                helperText: AppLocalizations.of(context)!.translate('input_title').capitalizeFirstLetter(),
                helperStyle: Theme.of(context)
                    .inputDecorationTheme
                    .helperStyle!
                    .copyWith(
                    color: Theme.of(context).textTheme.titleSmall!.color,
                    fontSize: helpTextFontSize),
              ),
            ),
          ),
        ),
      ),
    );

  }


  @override
  bool shouldRebuild(SliverInputHeader oldDelegate) {
    return false;
  }

  @override
  double get minExtent => minHeight!;
  @override
  double get maxExtent => math.max(maxHeight!, minHeight!);

}
