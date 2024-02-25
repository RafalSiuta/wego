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
    return SizedBox(
      height: 100,
      child:  AspectRatio(
        aspectRatio: 3/2,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size:24,
                color:  color,
              ),
              const SizedBox(height: 8.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child:Text(
                  AppLocalizations.of(context)!.translate(description!).capitalizeFirstLetter(),
                 // description!.capitalizeFirstLetter(),
                  overflow:TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displayMedium),
              )
            ],
          ),
        ),
      ),
    );
  }
}
