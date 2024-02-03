import 'package:flutter/material.dart';
import 'package:wego/utils/extensions/string_extension.dart';


class RadioTile extends StatelessWidget {
  const RadioTile({
    required this.onChoice,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.description,
    this.fontSize= 12.0,
    this.padding ,
    super.key});

  final ValueChanged<int?>? onChoice;
  final int? value;
  final int? groupValue;
  final String? title;
  final String? description;
  final double fontSize;
  final EdgeInsets? padding;


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var selectedText =  theme.textTheme.headlineMedium!.copyWith(
      fontSize: fontSize,height: 1.5);
    var unselectedText = theme.textTheme.displaySmall!.copyWith(
      fontSize: fontSize,height: 1.5);
    return Padding(
      padding: padding!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [


          Expanded(
            child: RichText(
                text: TextSpan(
                 text: title!.capitalizeFirstLetter(),

                 style: value == groupValue ? selectedText : unselectedText,

              children: <TextSpan>[
                TextSpan(text: "\n${description!.capitalizeFirstLetter()}",)
              ]
            ), overflow: TextOverflow.ellipsis,maxLines: 4,),
          ),
          const SizedBox(width: 10,),
          Radio(

            value: value!, groupValue: groupValue!, onChanged: onChoice,),

        ],
      ),
    );
  }
}
