import '../model/user_calendar_model/user_calendar_model.dart';
import '../utils/constans/prefs_keys.dart';

final List<UserCalendarModel> DUMMY_DATA = [

  UserCalendarModel(
      title: 'Back workout',
      subtitle: "Exercises",
      category: workoutCategory,
      imagePath: 'images/workout_dude.png',
      progressValue: 0.2,
      date: DateTime.now()

  ),
  UserCalendarModel(
      title: 'High calories',
      subtitle: "Meals",
      category: mealCategory,
      imagePath: 'images/food_1.png',
      date: DateTime.now(),
      progressValue: 0.7,
  ),
  UserCalendarModel(
      title: 'High hydration',
      subtitle: "Drinks",
      category: drinkCategory,
      imagePath: 'images/drink_1.png',
      date: DateTime.now(),
      progressValue: 0.8),
  UserCalendarModel(
      title: 'Supplements',
      subtitle: "Doses",
      category: supplementCategory,
      imagePath: 'images/supl_1.png',
      date: DateTime.now(),
      progressValue: 0.4
  ),
  UserCalendarModel(
    title: 'High calories',
    subtitle: "Meals",
    category: mealCategory,
    imagePath: 'images/food_1.png',
    progressValue: 0.7,
      date: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 2 )
  ),
  UserCalendarModel(
      title: 'Supplements',
      subtitle: "Doses",
      category: supplementCategory,
      imagePath: 'images/supl_1.png',
      progressValue: 0.4,
      date: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 2 )
  ),
  UserCalendarModel(
      title: 'High hydration',
      subtitle: "Drinks",
      category: drinkCategory,
      imagePath: 'images/drink_1.png',
      progressValue: 0.8,
      date: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 2 )
  ),

  UserCalendarModel(
      title: 'Back workout',
      subtitle: "Exercises",
      category: workoutCategory,
      imagePath: 'images/workout_dude.png',
      progressValue: 0.2,
      date: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 2 )

  ),
  UserCalendarModel(
      title: 'Chest workout',
      subtitle: "Exercises",
      category: workoutCategory,
      imagePath: 'images/workout_dude.png',
      progressValue: 0.2,
      date: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 2 )

  ),

  UserCalendarModel(
      title: 'High calories',
      subtitle: "Meals",
      category: mealCategory,
      imagePath: 'images/food_1.png',
      progressValue: 0.7,
      date: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 5 )
  ),
  UserCalendarModel(
      title: 'Supplements',
      subtitle: "Doses",
      category: supplementCategory,
      imagePath: 'images/supl_1.png',
      progressValue: 0.4,
      date: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 5 )
  ),
  UserCalendarModel(
      title: 'High hydration',
      subtitle: "Drinks",
      category: drinkCategory,
      imagePath: 'images/drink_1.png',
      progressValue: 0.8,
      date: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 5 )
  ),

  UserCalendarModel(
      title: 'Back workout',
      subtitle: "Exercises",
      category: workoutCategory,
      imagePath: 'images/workout_dude.png',
      progressValue: 0.2,
      date: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 5 )

  ),
];