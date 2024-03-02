import 'package:flutter/material.dart';
import 'package:wego/utils/extensions/string_extension.dart';

import '../../utils/internationalization/app_localizations.dart';


class SwitchTile extends StatelessWidget {
  const SwitchTile({
    required this.switchValue,
    required this.onChanged,
    required this.textValue1,
    required this.textValue2,
    this.fontSize= 12.0,
    this.padding = const EdgeInsets.only(left:12.0, right: 12.0, top: 16.0, bottom: 16.0),
    super.key});

  final bool? switchValue;
  final Function(bool)? onChanged;
  final String? textValue1;
  final String? textValue2;
  final double fontSize;
  final EdgeInsets padding;


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var selectedText =  theme.textTheme.headlineMedium!.copyWith(
      fontSize: fontSize,height: 1.5);
    var unselectedText = theme.textTheme.displaySmall!.copyWith(
      fontSize: fontSize,height: 1.5);
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Expanded(
            child: RichText(
                text: TextSpan(
                 text: AppLocalizations.of(context)!.translate(textValue1!).capitalizeFirstLetter(),
                 style: switchValue! ? selectedText : unselectedText,
              children: <TextSpan>[
                TextSpan(text: "\n${AppLocalizations.of(context)!.translate(textValue2!).capitalizeFirstLetter()}",style: !switchValue! ? selectedText : unselectedText,)
              ]
            ), overflow: TextOverflow.ellipsis,maxLines: 2,),
          ),
          const SizedBox(width: 10,),
          SizedBox(
            width: 50,
            child: Transform.scale(
              scale: 0.7,
              child: Switch(
                  value: switchValue!,
                  onChanged: onChanged
              ),
            ),
          ),

        ],
      ),
    );
  }
}
