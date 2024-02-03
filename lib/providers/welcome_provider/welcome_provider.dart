import 'dart:collection';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:wego/providers/calendar_provider/calendar_provider.dart';
import 'package:wego/utils/constans/prefs_keys.dart';
import '../../model/header_model/header_model.dart';
import '../../model/user_calendar_model/user_calendar_model.dart';

class WelcomeProvider extends ChangeNotifier{

  HeaderModel currentDate = HeaderModel();
  CalendarProvider calendarProvider;

  String? date;
  String? weekday;

  WelcomeProvider(this.calendarProvider){
    date = currentDate.fullDate.format(currentDate.date);
    weekday = currentDate.weekDay.format(currentDate.date);
  }

 // final List<UserCalendarModel> _userData = calendarProvider.taskList;
  // [
  //   UserCalendarModel(
  //       title: 'Back workout',
  //       subtitle: "Exercises",
  //       category: workoutCategory,
  //       imagePath: 'images/workout_dude.png',
  //       progressValue: 0.2
  //   ),
  //   UserCalendarModel(
  //       title: 'High calories',
  //       subtitle: "Meals",
  //       category: mealCategory,
  //       imagePath: 'images/food_1.png',
  //       date: DateTime.now(),
  //       progressValue: 0.7),
  //   UserCalendarModel(
  //       title: 'High hydration',
  //       subtitle: "Drinks",
  //       category: drinkCategory,
  //       imagePath: 'images/drink_1.png',
  //       date: DateTime.now(),
  //       progressValue: 0.8),
  //   UserCalendarModel(
  //       title: 'Supplements',
  //       subtitle: "Doses",
  //       category: supplementCategory,
  //       imagePath: 'images/supl_1.png',
  //       date: DateTime.now(),
  //       progressValue: 0.4),
  // ];

  // UnmodifiableListView<UserCalendarModel> get userDataCalendar {
  //   return UnmodifiableListView(_userData);
  // }
  //
  // int get userDataCalendarListCounter => _userData.length;

  CarouselController carouselController = CarouselController();

  int currentPage = 0;


  goToPrevious() {
    carouselController.previousPage(
        duration:const  Duration(milliseconds: 400), curve: Curves.ease);
    notifyListeners();
  }

  goToNext() {
    carouselController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.decelerate);
    notifyListeners();
  }

  onCarouselChange(int index){
    currentPage = index;
    notifyListeners();
  }

  void init(){

  }
}