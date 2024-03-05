import 'package:wego/model/user_calendar_model/calendar_items_model.dart';

import '../model/user_calendar_model/item_element.dart';
import '../model/user_calendar_model/user_calendar_model.dart';
import '../utils/constans/prefs_keys.dart';

final List<ItemElement>  workoutExerciseSets = [
  ItemElement(qty: 12, value:  60, unit: "reps", totalUnit: "kg"),
  ItemElement(qty: 10, value:  80, unit: "reps", totalUnit: "kg"),
  ItemElement(qty: 8, value:  100, unit: "reps", totalUnit: "kg"),
  ItemElement(qty: 6, value:  110, unit: "reps", totalUnit: "kg"),
  ItemElement(qty: 6, value:  120, unit: "reps", totalUnit: "kg"),
];
final List<ItemElement>  workoutExerciseSets2 = [
  ItemElement(qty: 10, value:  110, unit: "reps", totalUnit: "kg"),
  ItemElement(qty: 10, value:  110, unit: "reps", totalUnit: "kg"),
  ItemElement(qty: 10, value:  110, unit: "reps", totalUnit: "kg"),
  ItemElement(qty: 10, value:  110, unit: "reps", totalUnit: "kg"),
];

final List<ItemElement>  workoutExerciseSets3 = [
  ItemElement(qty: 12, value:  20, unit: "reps", totalUnit: "kg"),
  ItemElement(qty: 12, value:  30, unit: "reps", totalUnit: "kg"),
  ItemElement(qty: 10, value:  40, unit: "reps", totalUnit: "kg"),
];

final List<CalendarItemsModel> calendarWorkoutItems = [
  CalendarItemsModel(name: 'Podciąganie sztangi', qty: workoutExerciseSets.length, items: workoutExerciseSets),
  CalendarItemsModel(name: 'Podciąganie drążek',qty: workoutExerciseSets2.length, items: workoutExerciseSets2),
  CalendarItemsModel(name: 'Podciąganie hantli',qty: workoutExerciseSets.length, items: workoutExerciseSets),
  CalendarItemsModel(name: 'Martwe ciągi',qty: workoutExerciseSets3.length, items: workoutExerciseSets3),
] ;

final List<ItemElement>  calendarMealsDinner = [
  ItemElement(name:"Ryż", qty: 100,unit: "g", value:  300, totalUnit: "kcal"),
  ItemElement(name:"Udo indyk",qty: 120, unit: "g", value: 543, totalUnit: "kcal"),
  ItemElement(name:"surówka",qty: 70, unit: "g", value: 50, totalUnit: "kcal"),
];

final List<CalendarItemsModel> calendarMealsItems = [
  CalendarItemsModel(name: 'Breakfast', qty: calendarMealsDinner.length, items: calendarMealsDinner),
  CalendarItemsModel(name: 'Launch',qty: calendarMealsDinner.length, items: calendarMealsDinner),
  CalendarItemsModel(name: 'dinner',qty: calendarMealsDinner.length, items: calendarMealsDinner),
  CalendarItemsModel(name: 'suppper',qty: calendarMealsDinner.length, items: calendarMealsDinner),
] ;

final List<CalendarItemsModel> calendarDrinkItems = [
  CalendarItemsModel(name: 'Tea', qty: drinkItems.length, items: drinkItems),
  CalendarItemsModel(name: 'Coffee',qty: drinkItems.length, items: drinkItems),
  CalendarItemsModel(name: 'Water',qty: drinkItems.length, items: drinkItems),
] ;

final List<ItemElement>  drinkItems = [
  ItemElement(qty: 2, value:  0.5, unit: "szt", totalUnit: "l"),
  ItemElement(qty: 2, value:  0.5, unit: "szt", totalUnit: "l"),
  ItemElement(qty: 2, value:  0.5, unit: "szt", totalUnit: "l"),
];

final List<CalendarItemsModel> calendarSupplementsItems = [
  CalendarItemsModel(name: 'Creatine', qty: supplementsItems.length, items: supplementsItems),
  CalendarItemsModel(name: 'Vit-C',qty: supplementsItems.length, items: supplementsItems),
  CalendarItemsModel(name: 'ADEK',qty: supplementsItems.length, items: supplementsItems),
  CalendarItemsModel(name: 'Ginseng',qty: supplementsItems.length, items: supplementsItems),
] ;

final List<ItemElement>  supplementsItems = [
  ItemElement(qty: 1, value:  500, unit: "dawka", totalUnit: "mg"),
  ItemElement(qty: 2, value:  2500, unit: "dawka", totalUnit: "mg"),
];

final List<UserCalendarModel> DUMMY_DATA = [

  UserCalendarModel(
      title: 'Back workout',
      subtitle: workoutCategory,
      category: workoutCategory,
      imagePath: 'images/workout_dude.png',
      progressValue: 0.2,
      date: DateTime.now(),
      items: calendarWorkoutItems
  ),
  UserCalendarModel(
      title: 'High calories',
      subtitle: mealCategory,
      category: mealCategory,
      imagePath: 'images/food_1.png',
      date: DateTime.now(),
      progressValue: 0.7,
      items: calendarMealsItems,
  ),
  UserCalendarModel(
      title: 'High hydration',
      subtitle: drinkCategory,
      category: drinkCategory,
      imagePath: 'images/drink_1.png',
      date: DateTime.now(),
      items: calendarDrinkItems,
      progressValue: 0.8),
  UserCalendarModel(
      title: 'Supplements',
      subtitle: supplementCategory,
      category: supplementCategory,
      imagePath: 'images/supl_1.png',
      date: DateTime.now(),
      progressValue: 0.4,
      items: calendarSupplementsItems
  ),
  //############ new list
  UserCalendarModel(
    title: 'High calories',
    subtitle: mealCategory,
    category: mealCategory,
    imagePath: 'images/food_1.png',
    progressValue: 0.7,
      date: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 2 ),
    items: calendarMealsItems,
  ),
  UserCalendarModel(
      title: 'Supplements',
      subtitle: supplementCategory,
      category: supplementCategory,
      imagePath: 'images/supl_1.png',
      progressValue: 0.4,
      date: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 2 ),
      items: calendarSupplementsItems
  ),
  UserCalendarModel(
      title: 'High hydration',
      subtitle: drinkCategory,
      category: drinkCategory,
      imagePath: 'images/drink_1.png',
      progressValue: 0.8,
      date: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 2 ),
    items: calendarDrinkItems,
  ),

  UserCalendarModel(
      title: 'Back workout',
      subtitle: workoutCategory,
      category: workoutCategory,
      imagePath: 'images/workout_dude.png',
      progressValue: 0.2,
      date: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 2 ),
      items: calendarWorkoutItems

  ),
  UserCalendarModel(
      title: 'Chest workout',
      subtitle: workoutCategory,
      category: workoutCategory,
      imagePath: 'images/workout_dude.png',
      progressValue: 0.2,
      date: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 2 ),
      items: calendarWorkoutItems

  ),
  //############ new list
  UserCalendarModel(
      title: 'High calories',
      subtitle: mealCategory,
      category: mealCategory,
      imagePath: 'images/food_1.png',
      progressValue: 0.7,
      date: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 5 ),
      items: calendarMealsItems,
  ),
  UserCalendarModel(
      title: 'Supplements',
      subtitle: supplementCategory,
      category: supplementCategory,
      imagePath: 'images/supl_1.png',
      progressValue: 0.4,
      date: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 5 ),
      items: calendarSupplementsItems
  ),
  UserCalendarModel(
      title: 'High hydration',
      subtitle: drinkCategory,
      category: drinkCategory,
      imagePath: 'images/drink_1.png',
      progressValue: 0.8,
      date: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 5 ),
    items: calendarDrinkItems,
  ),

  UserCalendarModel(
      title: 'Back workout',
      subtitle: workoutCategory,
      category: workoutCategory,
      imagePath: 'images/workout_dude.png',
      progressValue: 0.2,
      date: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 5 ),
      items: calendarWorkoutItems

  ),
];