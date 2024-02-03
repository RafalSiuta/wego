import 'package:wego/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../utils/dimensions/size_info.dart';

class InfoText extends StatelessWidget {
  const InfoText({required this.title,required this.padding, super.key});

  final String? title;
  final EdgeInsets? padding;
 // final double fontSize;

  @override
  Widget build(BuildContext context) {
    var subtitleSize = SizeInfo.headerSubtitleSize;
    return Padding(
      padding: padding!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!.capitalizeFirstLetter(),
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: subtitleSize ),
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.info))
        ],
      ),
    );
  }
}
