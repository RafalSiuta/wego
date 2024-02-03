import 'package:wego/screens/profile_screen/profile_subscreens/user_activity_page.dart';
import 'package:wego/screens/profile_screen/profile_subscreens/user_data_page.dart';
import 'package:wego/screens/profile_screen/profile_subscreens/user_nutrition_page.dart';
import 'package:flutter/material.dart';
import '../../../widgets/navigators/tab_nav.dart';
import '../../model/menu/nav_model.dart';
import '../../model/menu/subscreen_model.dart';
import '../subscren_container.dart';


final  List<SubScreenModel> _profilePages = [
  SubScreenModel(
    page:  const UserDataPage(),
    title: NavModel(
      title: 'Personal',
    ),
  ),
  SubScreenModel(
    page: const UserActivityPage(),
    title: NavModel(
      title: 'Activity',
    ),
  ),
  SubScreenModel(
      page: const UserNutritionPage(),
      title: NavModel(
        title: 'Nutrition',
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
            tabTitles: [
              "Personal", "Activity", "Nutrition"
            ],
            list:[
              UserDataPage(),
              UserActivityPage(),
              UserNutritionPage()
            ]
          ),
        )
      ],
    );
    //return SubScreenContainer(pages: _profilePages,);
  }
}


//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//
//         Expanded(
//           child: TabNav(
//             tabTitles: [
//               "Personal", "Activity", "Nutrition"
//             ],
//             list:[
//               UserDataPage(),
//               UserActivityPage(),
//               UserNutritionPage()
//             ]
//           ),
//         )
//       ],
//     );
//   }
// }
