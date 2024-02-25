import 'package:flutter/material.dart';
import 'package:wego/utils/extensions/string_extension.dart';

import '../../model/choice_model/choice_model.dart';
import '../../utils/internationalization/app_localizations.dart';
class TileButton extends StatelessWidget {
  const TileButton({ this.tileSize = 100,this.choiceModel, this.onGenderSelect, super.key});

  final ChoiceModel? choiceModel;
  final double tileSize;
  final Function()? onGenderSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onGenderSelect,
      child: SizedBox(
        width: tileSize,
        height: tileSize,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                choiceModel!.icon,
                size:24,
                color: choiceModel!.groupValue == choiceModel!.selectedValue ? Theme.of(context).iconTheme.color : Theme.of(context).unselectedWidgetColor,
              ),
              const SizedBox(height: 8.0,),
              Text(
                AppLocalizations.of(context)!.translate(choiceModel!.title!).capitalizeFirstLetter(),
               // choiceModel!.title!.capitalizeFirstLetter(),
                style:choiceModel!.groupValue == choiceModel!.selectedValue ? Theme.of(context).textTheme.displayMedium : Theme.of(context).textTheme.displaySmall ,)
            ],
          ),
        ),
      ),
    );
  }
}
