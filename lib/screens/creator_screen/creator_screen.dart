import 'package:flutter/material.dart';
import '../../model/menu/nav_model.dart';
import '../../model/menu/subscreen_model.dart';
import '../../widgets/navigators/tab_nav.dart';
import '../subscren_container.dart';
import 'creator_subscreens/drink_creator_screen.dart';
import 'creator_subscreens/meals_creator_screen.dart';
import 'creator_subscreens/supplements_creator_screen.dart';
import 'creator_subscreens/workout_creator_screen.dart';

final  List<SubScreenModel> _creatorPages = [
  SubScreenModel(
    page:  const WorkoutCreatorScreen(),
    title: NavModel(
      title: 'nav_workout',
    ),
  ),
  SubScreenModel(
    page: const MealsCreatorScreen(),
    title: NavModel(
      title: 'nav_meals',
    ),
  ),
  SubScreenModel(
      page: const DrinksCreatorScreen(),
      title: NavModel(
        title: 'nav_drinks',
      )),
  SubScreenModel(
      page: const SupplementsCreatorScreen(),
      title: NavModel(
        title: 'nav_supl',
      ))
];

class CreatorScreen extends StatelessWidget {
  const CreatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SubScreenContainer(pages: _creatorPages,);

  }
}
