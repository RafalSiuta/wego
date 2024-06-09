import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wego/widgets/responsive/column_row_builder.dart';

import '../../../model/menu/nav_model.dart';
import '../../../utils/dimensions/size_info.dart';
import '../../../utils/internationalization/app_localizations.dart';
import '../../../widgets/buttons/menu_button.dart';
import '../../../widgets/cards/app_logo.dart';

final List<NavModel> _menuItems = [
      NavModel(
      icon:Icons.share,
      title: 'share'
      ),
  NavModel(
      icon:FontAwesomeIcons.globe,
      title: 'web'
  ),
  NavModel(
      icon:Icons.favorite_border,
      title: 'rate'
  ),

];

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    var descriptionFontSize = SizeInfo.taskCreatorDescription;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              height: 50,
            ),
            AppLogo(
              imageName: 'playstore',
              imgSize: 150,
            ),
            SizedBox(
              height: 30,
            ),
            RowBuilder(
              itemCount: _menuItems.length,
              itemBuilder: (context,index){
                var item = _menuItems[index];
                return MenuButton(
                  icon: item.icon,
                  title: item.title,
                  spaceMargin: 12,
                  onPress: (){

                  },
                );
              },),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          AppLocalizations.of(context)!.translate('policy'),
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(height: 1.8, fontSize: descriptionFontSize),
        ),
        SizedBox(
          height: 20,
        ),

      ],
    );
  }
}
