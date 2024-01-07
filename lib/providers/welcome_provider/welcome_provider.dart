import 'dart:collection';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

import '../../model/header_model/header_model.dart';
import '../../model/user_calendar_model/user_calendar_model.dart';

class WelcomeProvider extends ChangeNotifier{

  HeaderModel currentDate = HeaderModel();

  String? date;
  String? weekday;

  WelcomeProvider(){
    date = currentDate.fullDate.format(currentDate.date);
    weekday = currentDate.weekDay.format(currentDate.date);
  }

  final List<UserCalendarModel> _userData = [
    UserCalendarModel(
        title: 'Workout',
        imagePath: 'images/workout_dude.png',
        progressValue: 0.2
    ),
    UserCalendarModel(
        title: 'Meals',
        imagePath: 'images/food_1.png',
        progressValue: 0.7),
    UserCalendarModel(
        title: 'Drinks',
        imagePath: 'images/workout_dude.png',
        progressValue: 0.8),
    UserCalendarModel(
        title: 'Supplements',
        imagePath: 'images/workout_dude.png',
        progressValue: 0.4),
  ];

  UnmodifiableListView<UserCalendarModel> get userDataCalendar {
    return UnmodifiableListView(_userData);
  }

  int get userDataCalendarListCounter => _userData.length;

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