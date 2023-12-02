import 'package:flutter/material.dart';

import '../../widgets/navigators/tab_nav.dart';
import 'creator_subscreens/meals_creator_screen.dart';
import 'creator_subscreens/supplements_creator_screen.dart';
import 'creator_subscreens/workout_creator_screen.dart';

class CreatorScreen extends StatelessWidget {
  const CreatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Expanded(
          child: TabNav(
              tabTitles: [
                "Workout", "Meals", "Suplements"
              ],
              list:[
                WorkoutCreatorScreen(),
                MealsCreatorScreen(),
                SupplementsCreatorScreen()
              ]
          ),
        )
      ],
    );
  }
}
