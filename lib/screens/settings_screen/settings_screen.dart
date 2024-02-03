import 'package:wego/screens/settings_screen/settings_subscreens/advanced_page.dart';
import 'package:wego/screens/settings_screen/settings_subscreens/settings_page.dart';
import 'package:flutter/material.dart';
import '../../model/menu/nav_model.dart';
import '../../model/menu/subscreen_model.dart';
import '../../widgets/navigators/tab_nav.dart';
import '../subscren_container.dart';


final  List<SubScreenModel> _settingsPages = [
  SubScreenModel(
    page:  const SettingsPage(),
    title: NavModel(
      title: 'Settings',
    ),
  ),
  SubScreenModel(
    page: const Center(child: Text("about"),),
    title: NavModel(
      title: 'About',
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
            tabTitles: ["Settings","Advanced", "About"],
              list:[
                SettingsPage(),
                AdvancedPage(),
                Center(child: Text("about"),)
              ]
          ),
        )
      ],
    );
  }
}
