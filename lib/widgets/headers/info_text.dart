import 'package:wego/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  const InfoText({required this.title,required this.padding, this.fontSize = 12.0, super.key});

  final String? title;
  final EdgeInsets? padding;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!.capitalizeFirstLetter(),
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: fontSize ),
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.info))
        ],
      ),
    );
  }
}
