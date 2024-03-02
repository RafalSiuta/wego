import 'package:wego/screens/settings_screen/settings_subscreens/about_page.dart';
import 'package:wego/screens/settings_screen/settings_subscreens/advanced_page.dart';
import 'package:wego/screens/settings_screen/settings_subscreens/settings_page.dart';
import 'package:flutter/material.dart';
import '../../model/menu/nav_model.dart';
import '../../model/menu/subscreen_model.dart';
import '../../widgets/navigators/tab_nav.dart';


final  List<SubScreenModel> _settingsPages = [
  SubScreenModel(
    page:  const SettingsPage(),
    title: NavModel(
      title: 'nav_sets',
    ),
  ),
  SubScreenModel(
    page:  const AdvancedPage(),
    title: NavModel(
      title: 'nav_sets_adv',
    ),
  ),
  SubScreenModel(
    page: const AboutPage(),
    title: NavModel(
      title: 'nav_about',
    ),
  ),
];

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
      //SubScreenContainer(pages: _settingsPages,);

      Column(
      children: [

        Expanded(
          child: TabNav(
            pages: _settingsPages,
          ),
        )
      ],
    );
  }
}
