import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wego/model/user_calendar_model/user_calendar_model.dart';
import 'package:wego/utils/constans/prefs_keys.dart';
import '../../utils/prefs/prefs.dart';
import '../settings_provider/settings_provider.dart';
import 'package:wego/data/dummy_data_list.dart';

class CalendarProvider extends ChangeNotifier {

  CalendarProvider(this.settings) {
    initCalendarData();
  }

  SettingsProvider settings;
  final Prefs _prefs = Prefs();

  void initCalendarData() async {
    getAllTasks();
  }

  DateTime focDay =
  DateTime(DateTime
      .now()
      .year, DateTime
      .now()
      .month, DateTime
      .now()
      .day);
  DateTime selDay =
  DateTime(DateTime
      .now()
      .year, DateTime
      .now()
      .month, DateTime
      .now()
      .day);
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOff;
  Map<DateTime, List<UserCalendarModel>> tasks = {};

  // temp dummy data:
  List<UserCalendarModel> _taskList = [];//DUMMY_DATA;

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

  getAllTasks() {
    // Sortujemy listę DUMMY_DATA za pomocą funkcji porównującej
    DUMMY_DATA.sort(compareByCategory);

// Teraz mamy posortowaną listę według kategorii, możesz ją przekształcić na nową listę w tej kolejności
    _taskList = DUMMY_DATA.toList();

// Wyświetlamy posortowaną listę
//     sortedList.forEach((item) {
//       print("${item.title}, ${item.category}");
//     });

    _taskList.forEach((element) {
      print('ALL ASKS LOADED ${element.title}');
      var addDate =
      DateTime(element.date!.year, element.date!.month, element.date!.day);
      addTaskMarker(element, addDate);
    });
  }
  final categoryOrder = [
    workoutCategory,
    mealCategory,
    drinkCategory,
    supplementCategory,
  ];
  int compareByCategory(UserCalendarModel a, UserCalendarModel b) {
    // Kolejność kategorii, w której chcesz posortować


    // Pobieramy indeksy kategorii dla obiektów a i b
    final indexA = categoryOrder.indexOf(a.category!);
    final indexB = categoryOrder.indexOf(b.category!);

    // Porównujemy indeksy kategorii
    return indexA.compareTo(indexB);
  }

  int countItemsInCategory(List<UserCalendarModel> sortedList, String category) {
    int count = 0;

    for (UserCalendarModel item in sortedList) {
      if (item.category == category) {
        count++;
      }
    }
    return count;
  }


}