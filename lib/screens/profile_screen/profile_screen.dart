import 'package:wego/screens/profile_screen/profile_subscreens/user_activity_page.dart';
import 'package:wego/screens/profile_screen/profile_subscreens/user_data_page.dart';
import 'package:wego/screens/profile_screen/profile_subscreens/user_nutrition_page.dart';
import 'package:flutter/material.dart';
import '../../../widgets/navigators/tab_nav.dart';
import '../../model/menu/nav_model.dart';
import '../../model/menu/subscreen_model.dart';


final  List<SubScreenModel> _profilePages = [
  SubScreenModel(
    page:  const UserDataPage(),
    title: NavModel(
      title: 'nav_person',
    ),
  ),
  SubScreenModel(
    page: const UserActivityPage(),
    title: NavModel(
      title: 'nav_activity',
    ),
  ),
  SubScreenModel(
      page: const UserNutritionPage(),
      title: NavModel(
        title: 'nav_nutri',
      ))
];

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
        return Column(
      children: [

        Expanded(
          child: TabNav(
            pages: _profilePages,
          ),
        )
      ],
    );
  }
}

