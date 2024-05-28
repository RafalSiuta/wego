

import 'package:flutter/cupertino.dart';

import '../../model/user_calendar_model/user_calendar_model.dart';
import '../../utils/constans/prefs_keys.dart';
import '../calendar_provider/calendar_provider.dart';

class CreatorProvider extends ChangeNotifier{

  CreatorProvider(this.calendar){
    creatorList();
  }
  CalendarProvider calendar;

  List<UserCalendarModel> workoutList = [];
  List<UserCalendarModel> mealsList = [];
  List<UserCalendarModel> drinkList = [];
  List<UserCalendarModel> supplementList = [];

  void creatorList(){
    calendar.dummyDBList.sort(calendar.compareByCategory);

    List<UserCalendarModel> list = [];

    list = calendar.dummyDBList.toList();

    for (UserCalendarModel item in list) {
      switch (item.category){
        case workoutCategory:
          workoutList.add(item);
          break;
      case mealCategory:
          mealsList.add(item);
          break;
      case drinkCategory:
          drinkList.add(item);
          break;
      case supplementCategory:
        supplementList.add(item);
          break;
      }
    }
    notifyListeners();
  }
}