import 'package:flutter/material.dart';
import 'package:wego/utils/extensions/string_extension.dart';

import '../../utils/internationalization/app_localizations.dart';

class SliderCard extends StatelessWidget {
  const SliderCard({required this.icon, required this.description, this.color = Colors.amber, super.key});

  final IconData? icon;
  final Color? color;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          child: SizedBox(
            width: 100,
            height: 100,
            child: Icon(
              icon,
              size:36,
              color:  color,
            ),
          ),
        ),
        const SizedBox(height: 8.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child:Text(
            AppLocalizations.of(context)!.translate(description!).capitalizeFirstLetter(),
            overflow:TextOverflow.ellipsis,
            maxLines: 2,
            style: Theme.of(context).textTheme.displayMedium),
        )
      ],
    );
  }
}
