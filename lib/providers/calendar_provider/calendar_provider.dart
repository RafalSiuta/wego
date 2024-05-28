import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wego/model/user_calendar_model/user_calendar_model.dart';
import 'package:wego/utils/constans/prefs_keys.dart';
import '../../data/dummy_chart_data.dart';
import '../../model/chart_model/chart_model.dart';
import '../../model/choice_model/chip_choice.dart';
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
    dummyDBList = DUMMY_DATA;
    getAllTasks();
    loadDefaultCharts();
  }



  DateTime currentDay =
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
  List<UserCalendarModel> dummyDBList = [];

  List<UserCalendarModel> _taskList = [];//DUMMY_DATA;

  List<UserCalendarModel> _welcomeList = [];


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
    currentDay = DateTime(day.year, day.month, 1);
    notifyListeners();
  }

  void onDaySelected(selectedDay, focusedDay) async {
    if (!isSameDay(selDay, selectedDay)) {
      selDay = selectedDay;
      currentDay = focusedDay;
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
    _taskList = getCalendarValues(currentDay);
    notifyListeners();
  }

  UnmodifiableListView<UserCalendarModel> get taskList {
    return UnmodifiableListView(_taskList);
  }

  int get taskListCounter {
    return _taskList.length;
  }

  UnmodifiableListView<UserCalendarModel> get welcomeTaskList {
    return UnmodifiableListView(_welcomeList);
  }

  int get welcomeTaskListCounter {
    return _welcomeList.length;
  }

  getAllTasks() {
    // Sortujemy listę DUMMY_DATA za pomocą funkcji porównującej
    dummyDBList.sort(compareByCategory);

// Teraz mamy posortowaną listę według kategorii, możesz ją przekształcić na nową listę w tej kolejności
    _taskList = dummyDBList.toList();


    _taskList.forEach((element) {
      print('ALL ASKS LOADED ${element.title}');
      var addDate =
      DateTime(element.date!.year, element.date!.month, element.date!.day);
      addTaskMarker(element, addDate);
      if(addDate == currentDay){
        _welcomeList.add(element);
      }
    });
    notifyListeners();

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

  List<ChipChoice> categoryChartList = [
    ChipChoice(name:'chips_workout' ,category: workoutCategory, value:false),
    ChipChoice(name:'chips_calories', category: mealCategory, value:false),
    ChipChoice(name:'chips_hydro', category: drinkCategory, value:false),
    ChipChoice(name:'chips_supplements' ,category: supplementCategory, value:false),
  ];
  // void calendarChipChoice(int index, bool val){
  //   categoryChartList[index].value = val;
  //  // _prefs.storeList(chipChoiceListKey, categoryChartList);
  //   notifyListeners();
  // }
  String selectedChartCategory = '';

  List<ChartModel> selectedChartList = [];

  void loadDefaultCharts(){
    categoryChartList.first.value = true;
    selectedChartCategory = categoryChartList.first.category!;
    updateChartList();
    notifyListeners();
  }
//todo temporary solution change to load from main DB list saves:
  void updateChartList(){
    switch (selectedChartCategory){
      case workoutCategory:
        selectedChartList = DUMMY_WORKOUT_CHART_DATA;
        break;
      case mealCategory:
        selectedChartList = DUMMY_CALORIES_CHART_DATA;
        break;
      case drinkCategory:
        selectedChartList = DUMMY_DRINK_CHART_DATA;
        break;
      case supplementCategory:
        selectedChartList = DUMMY_SUPPLEMENTS_CHART_DATA;
        break;
      default: DUMMY_WORKOUT_CHART_DATA;

    }
    notifyListeners();
  }



  void calendarChipChoice(int index, bool val) {
    for (int i = 0; i < categoryChartList.length; i++) {
      categoryChartList[i].value = (i == index) && val;

    }
    selectedChartCategory = categoryChartList[index].category!;
    updateChartList();
    notifyListeners();
    // _prefs.storeList(chipChoiceListKey, categoryChartList); // Jeśli używasz zapisu stanu
  }


}