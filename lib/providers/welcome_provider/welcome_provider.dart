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
  DateTime? today;

  WelcomeProvider(this.calendarProvider){
    date = currentDate.fullDate.format(currentDate.date);
    weekday = currentDate.weekDay.format(currentDate.date);
    today = DateTime.now();
  }


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