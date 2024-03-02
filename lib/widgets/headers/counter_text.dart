import 'package:flutter/material.dart';
import 'package:wego/utils/extensions/string_extension.dart';

import '../../utils/dimensions/size_info.dart';
import '../../utils/internationalization/app_localizations.dart';

class CounterText extends StatelessWidget {
  const CounterText({required this.text1,required this.text2, required this.valueCount, required this.padding, super.key});

  final String? text1;
  final String? text2;
  final String? valueCount;
  final EdgeInsets? padding;
  // final double fontSize;

  @override
  Widget build(BuildContext context) {
    var subtitleSize = SizeInfo.headerSubtitleSize;
    return Padding(
      padding: padding!,
      child: RichText(
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          maxLines: 1,
          text: TextSpan(
              text: AppLocalizations.of(context)!.translate(text1!).capitalizeFirstLetter(),
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: subtitleSize,),
              children: <TextSpan>[
                TextSpan(
                  text: " ${valueCount} ",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith( fontSize: subtitleSize),
                ),
                TextSpan(
                  text: AppLocalizations.of(context)!.translate(text2!),
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith( fontSize: subtitleSize),
                )
              ]
          )),
    );
  }
}
