

import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wego/model/user_calendar_model/user_calendar_model.dart';
import 'package:wego/utils/constans/prefs_keys.dart';
import '../../utils/prefs/prefs.dart';
import '../settings_provider/settings_provider.dart';

class CalendarProvider extends ChangeNotifier {

  CalendarProvider(this.settings){
    initCalendarData();
  }

  SettingsProvider settings;
  final Prefs _prefs = Prefs();

  void initCalendarData() async{

  }

  DateTime focDay =
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime selDay =
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOff;
  Map<DateTime, List<UserCalendarModel>> tasks = {};
  //todo temp dummy data:
  List<UserCalendarModel> _taskList = [
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
  CalendarFormat format = CalendarFormat.month;
  late final PageController pageController;

  void changeDateFormat(CalendarFormat calendarFormat) {
    format = calendarFormat;
    _prefs.storeInt(calendarFormatKey, format.index);
    notifyListeners();
  }

  void loadCalendarFormat() async {
    int formatIndex = await _prefs.restoreInt(calendarFormatKey, 0);
    format = CalendarFormat.values[formatIndex];
    notifyListeners();
  }

  onMonthChange(DateTime day) {
    focDay = DateTime(day.year, day.month, 1);
    notifyListeners();
  }

  void onDaySelected(selectedDay, focusedDay) async {
    if (!isSameDay(selDay, selectedDay)) {
      selDay = selectedDay;
      focDay = focusedDay;
      _rangeStart = null;
      _rangeEnd = null;
      rangeSelectionMode = RangeSelectionMode.toggledOff;
    }
    _taskList = getCalendarValues(selDay);
    notifyListeners();
  }

  List<UserCalendarModel> getCalendarValues(DateTime date) {
    date = DateTime(date.year, date.month, date.day);
    return tasks[date] ?? [];
  }

  void addTaskMarker(UserCalendarModel task, DateTime addDate) {
    addDate = DateTime(addDate.year, addDate.month, addDate.day);
    if (tasks[addDate] != null) {
      tasks[addDate]!.add(task);
    } else {
      tasks[addDate] = [task];
    }
    _taskList = getCalendarValues(focDay);
    notifyListeners();
  }

  UnmodifiableListView<UserCalendarModel> get taskList {
    return UnmodifiableListView(_taskList);
  }

  int get taskListCounter {
    return _taskList.length;
  }


}