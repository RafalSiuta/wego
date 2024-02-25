import 'package:wego/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../utils/dimensions/size_info.dart';
import '../../utils/internationalization/app_localizations.dart';

class InfoText extends StatelessWidget {
  const InfoText({required this.title,required this.padding, this.isInfoIcon = true, super.key});

  final String? title;
  final EdgeInsets? padding;
  final bool? isInfoIcon;
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
            AppLocalizations.of(context)!.translate(title!).capitalizeFirstLetter(),
            //title!.capitalizeFirstLetter(),
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: subtitleSize ),
          ),
          Visibility(
              visible: isInfoIcon ?? true,
              child: IconButton(onPressed: (){}, icon: const Icon(Icons.info_outline)))
        ],
      ),
    );
  }
}
