import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wego/providers/creator_provider/creator_provider.dart';
import '../../model/menu/nav_model.dart';
import '../../model/menu/subscreen_model.dart';
import '../../widgets/list/creator_list.dart';
import '../subscren_container.dart';



class CreatorScreen extends StatelessWidget {
  const CreatorScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<CreatorProvider>(

      builder:(context,creatorProvider,child){
        final  List<SubScreenModel> _creatorPages = [
          SubScreenModel(
            page:  CreatorList(
            titleKey: "plans_workout",
              list: creatorProvider.workoutList,
          ),
            title: NavModel(
              title: 'nav_workout',
            ),
          ),
          SubScreenModel(
            page: CreatorList(
              titleKey: "plans_meals",
              list: creatorProvider.mealsList,
            ),
            title: NavModel(
              title: 'nav_meals',
            ),
          ),
          SubScreenModel(
              page: CreatorList(
                titleKey: "plans_drink",
                list: creatorProvider.drinkList,
              ),
              title: NavModel(
                title: 'nav_drinks',
              )),
          SubScreenModel(
              page: CreatorList(
                titleKey: "plans_supplement",
                list: creatorProvider.supplementList,
              ),
              title: NavModel(
                title: 'nav_supl',
              ))
        ];
        return SubScreenContainer(pages: _creatorPages,);
      }
    );

  }
}
