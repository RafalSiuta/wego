import 'package:flutter/material.dart';
import 'package:wego/utils/extensions/string_extension.dart';

import '../../utils/internationalization/app_localizations.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({required this.title, required this.icon, this.spaceMargin = 5.0, this.fontSize = 8.0, required this.onPress, this.isChecked = false, super.key});

  final String? title;
  final IconData? icon;
  final double? spaceMargin;
  final double? fontSize;
  final VoidCallback? onPress;
  final bool? isChecked;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisSize: MainAxisSize.min,
        children: [
          Icon( // <-- Icon
            icon,
            size: fontSize! + 10,
            color: isChecked! ? Theme.of(context).indicatorColor : Theme.of(context).unselectedWidgetColor,
          ),
          SizedBox(
            //width: spaceMargin,
            height: spaceMargin,
          ),
          Text(
            AppLocalizations.of(context)!.translate(title!).capitalizeFirstLetter(),
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: fontSize, color: isChecked! ? Theme.of(context).indicatorColor : Theme.of(context).unselectedWidgetColor ),
          ),
        ],
      ),
    );
  }
}
