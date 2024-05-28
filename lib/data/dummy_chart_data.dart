import 'package:wego/model/chart_model/chart_model.dart';

final List<ChartModel> DUMMY_WORKOUT_CHART_DATA = [
  ChartModel(1, DateTime.now(), 6510, 'kg'),
  ChartModel(2, DateTime(DateTime.now().year,DateTime.now().month + 1,DateTime.now().day + 2 ), 7239, 'kg'),
  ChartModel(3, DateTime(DateTime.now().year,DateTime.now().month + 2,DateTime.now().day + 1 ), 8927.1, 'kg'),
  ChartModel(4, DateTime(DateTime.now().year,DateTime.now().month + 3,DateTime.now().day + 1 ), 5959.3, 'kg'),
  ChartModel(5, DateTime(DateTime.now().year,DateTime.now().month + 4,DateTime.now().day + 5 ), 7584.8, 'kg'),
  ChartModel(6, DateTime(DateTime.now().year,DateTime.now().month + 5,DateTime.now().day + 3 ), 9100.2, 'kg'),
  ChartModel(7, DateTime(DateTime.now().year,DateTime.now().month + 6,DateTime.now().day + 2 ), 10102, 'kg'),
  ChartModel(8, DateTime(DateTime.now().year,DateTime.now().month + 7,DateTime.now().day + 5 ), 9582.8, 'kg'),
  ChartModel(9, DateTime(DateTime.now().year,DateTime.now().month + 8,DateTime.now().day + 3 ), 6034.2, 'kg'),
  ChartModel(10, DateTime(DateTime.now().year,DateTime.now().month + 9,DateTime.now().day + 2 ), 8127, 'kg'),
];

final List<ChartModel> DUMMY_CALORIES_CHART_DATA = [
  ChartModel(1, DateTime.now(), 2510, 'kcal'),
  ChartModel(2, DateTime(DateTime.now().year,DateTime.now().month + 1,DateTime.now().day + 2 ), 2239, 'kcal'),
  ChartModel(3, DateTime(DateTime.now().year,DateTime.now().month + 2,DateTime.now().day + 1 ), 2927.1, 'kcal'),
  ChartModel(4, DateTime(DateTime.now().year,DateTime.now().month + 3,DateTime.now().day + 1 ), 2959.3, 'kcal'),
  ChartModel(5, DateTime(DateTime.now().year,DateTime.now().month + 4,DateTime.now().day + 5 ), 1584.8, 'kcal'),
  ChartModel(6, DateTime(DateTime.now().year,DateTime.now().month + 5,DateTime.now().day + 3 ), 4100.2, 'kcal'),
  ChartModel(7, DateTime(DateTime.now().year,DateTime.now().month + 6,DateTime.now().day + 2 ), 3102, 'kcal'),
  ChartModel(8, DateTime(DateTime.now().year,DateTime.now().month + 7,DateTime.now().day + 5 ), 1582.8, 'kcal'),
  ChartModel(9, DateTime(DateTime.now().year,DateTime.now().month + 8,DateTime.now().day + 3 ), 4034.2, 'kcal'),
  ChartModel(10, DateTime(DateTime.now().year,DateTime.now().month + 9,DateTime.now().day + 2 ), 3127, 'kcal'),
];

final List<ChartModel> DUMMY_DRINK_CHART_DATA = [
  ChartModel(1, DateTime.now(), 2.5, 'L'),
  ChartModel(2, DateTime(DateTime.now().year,DateTime.now().month + 1,DateTime.now().day + 2 ), 2.8, 'L'),
  ChartModel(3, DateTime(DateTime.now().year,DateTime.now().month + 2,DateTime.now().day + 1 ), 2.95, 'L'),
  ChartModel(4, DateTime(DateTime.now().year,DateTime.now().month + 3,DateTime.now().day + 1 ), 3.45, 'L'),
  ChartModel(5, DateTime(DateTime.now().year,DateTime.now().month + 4,DateTime.now().day + 5 ), 5.1, 'L'),
  ChartModel(6, DateTime(DateTime.now().year,DateTime.now().month + 5,DateTime.now().day + 3 ), 3.4, 'L'),
  ChartModel(7, DateTime(DateTime.now().year,DateTime.now().month + 6,DateTime.now().day + 2 ), 4.2, 'L'),
  ChartModel(8, DateTime(DateTime.now().year,DateTime.now().month + 7,DateTime.now().day + 5 ), 3.1, 'L'),
  ChartModel(9, DateTime(DateTime.now().year,DateTime.now().month + 8,DateTime.now().day + 3 ), 4.8, 'L'),
  ChartModel(10, DateTime(DateTime.now().year,DateTime.now().month + 9,DateTime.now().day + 2 ), 3.3, 'L'),
];

final List<ChartModel> DUMMY_SUPPLEMENTS_CHART_DATA = [
  ChartModel(1, DateTime.now(), 251, 'mg'),
  ChartModel(2, DateTime(DateTime.now().year,DateTime.now().month + 1,DateTime.now().day + 2 ), 221.8, 'mg'),
  ChartModel(3, DateTime(DateTime.now().year,DateTime.now().month + 2,DateTime.now().day + 1 ), 29.4, 'mg'),
  ChartModel(4, DateTime(DateTime.now().year,DateTime.now().month + 3,DateTime.now().day + 1 ), 312, 'mg'),
  ChartModel(5, DateTime(DateTime.now().year,DateTime.now().month + 4,DateTime.now().day + 5 ), 158.3, 'mg'),
  ChartModel(6, DateTime(DateTime.now().year,DateTime.now().month + 5,DateTime.now().day + 3 ), 410.2, 'mg'),
  ChartModel(7, DateTime(DateTime.now().year,DateTime.now().month + 6,DateTime.now().day + 2 ), 31.2, 'mg'),
  ChartModel(8, DateTime(DateTime.now().year,DateTime.now().month + 7,DateTime.now().day + 5 ), 159.8, 'mg'),
  ChartModel(9, DateTime(DateTime.now().year,DateTime.now().month + 8,DateTime.now().day + 3 ), 403.2, 'mg'),
  ChartModel(10, DateTime(DateTime.now().year,DateTime.now().month + 9,DateTime.now().day + 2 ), 312, 'mg'),
];

final List<ChartModel> DUMMY_BMI_CHART_DATA = [
  ChartModel(1, DateTime.now(), 25.3, 'good'),
  ChartModel(2, DateTime(DateTime.now().year,DateTime.now().month + 1,DateTime.now().day + 2 ), 22.1, 'good'),
  ChartModel(3, DateTime(DateTime.now().year,DateTime.now().month + 2,DateTime.now().day + 1 ), 29.4, 'overweight'),
  ChartModel(4, DateTime(DateTime.now().year,DateTime.now().month + 3,DateTime.now().day + 1 ), 25, 'good'),
  ChartModel(5, DateTime(DateTime.now().year,DateTime.now().month + 4,DateTime.now().day + 5 ), 26.1, 'good'),
  ChartModel(6, DateTime(DateTime.now().year,DateTime.now().month + 5,DateTime.now().day + 3 ), 25.6, 'good'),
  ChartModel(7, DateTime(DateTime.now().year,DateTime.now().month + 6,DateTime.now().day + 2 ), 25, 'good'),
  ChartModel(8, DateTime(DateTime.now().year,DateTime.now().month + 7,DateTime.now().day + 5 ), 25, 'good'),
];

final List<ChartModel> DUMMY_WEIGHT_CHART_DATA = [
  ChartModel(1, DateTime.now(), 107.5, 'kg'),
  ChartModel(2, DateTime(DateTime.now().year,DateTime.now().month + 1,DateTime.now().day + 2 ), 105.2, 'kg'),
  ChartModel(3, DateTime(DateTime.now().year,DateTime.now().month + 2,DateTime.now().day + 1 ), 105.0, 'kg'),
  ChartModel(4, DateTime(DateTime.now().year,DateTime.now().month + 3,DateTime.now().day + 1 ), 108, 'kg'),
  ChartModel(5, DateTime(DateTime.now().year,DateTime.now().month + 4,DateTime.now().day + 5 ), 107.8, 'kg'),
  ChartModel(6, DateTime(DateTime.now().year,DateTime.now().month + 5,DateTime.now().day + 3 ), 106.5, 'kg'),
  ChartModel(7, DateTime(DateTime.now().year,DateTime.now().month + 6,DateTime.now().day + 2 ), 104.9, 'kg'),
  ChartModel(8, DateTime(DateTime.now().year,DateTime.now().month + 7,DateTime.now().day + 5 ), 107, 'kg'),
  ChartModel(9, DateTime(DateTime.now().year,DateTime.now().month + 6,DateTime.now().day + 2 ), 110, 'kg'),
  ChartModel(10, DateTime(DateTime.now().year,DateTime.now().month + 7,DateTime.now().day + 5 ), 112, 'kg'),
];

final List<ChartModel> DUMMY_WAIST_CHART_DATA = [
  ChartModel(1, DateTime.now(), 98, 'cm'),
  ChartModel(2, DateTime(DateTime.now().year,DateTime.now().month + 1,DateTime.now().day + 2 ), 102, 'cm'),
  ChartModel(3, DateTime(DateTime.now().year,DateTime.now().month + 2,DateTime.now().day + 1 ), 99, 'cm'),
  ChartModel(4, DateTime(DateTime.now().year,DateTime.now().month + 3,DateTime.now().day + 1 ), 97, 'cm'),
  ChartModel(5, DateTime(DateTime.now().year,DateTime.now().month + 4,DateTime.now().day + 5 ), 105, 'cm'),
  ChartModel(6, DateTime(DateTime.now().year,DateTime.now().month + 5,DateTime.now().day + 3 ), 98, 'cm'),
  ChartModel(7, DateTime(DateTime.now().year,DateTime.now().month + 6,DateTime.now().day + 2 ), 104.9, 'cm'),
  ChartModel(8, DateTime(DateTime.now().year,DateTime.now().month + 7,DateTime.now().day + 5 ), 97, 'cm'),
  ChartModel(9, DateTime(DateTime.now().year,DateTime.now().month + 6,DateTime.now().day + 2 ), 102, 'cm'),
  ChartModel(10, DateTime(DateTime.now().year,DateTime.now().month + 7,DateTime.now().day + 5 ), 105, 'cm'),
];

final List<ChartModel> DUMMY_HIPS_CHART_DATA = [
  ChartModel(1, DateTime.now(), 105, 'cm'),
  ChartModel(2, DateTime(DateTime.now().year,DateTime.now().month + 1,DateTime.now().day + 2 ), 108, 'cm'),
  ChartModel(3, DateTime(DateTime.now().year,DateTime.now().month + 2,DateTime.now().day + 1 ), 108, 'cm'),
  ChartModel(4, DateTime(DateTime.now().year,DateTime.now().month + 3,DateTime.now().day + 1 ), 108, 'cm'),
  ChartModel(5, DateTime(DateTime.now().year,DateTime.now().month + 4,DateTime.now().day + 5 ), 105, 'cm'),
  ChartModel(6, DateTime(DateTime.now().year,DateTime.now().month + 5,DateTime.now().day + 3 ), 110, 'cm'),
  ChartModel(7, DateTime(DateTime.now().year,DateTime.now().month + 6,DateTime.now().day + 2 ), 108, 'cm'),
  ChartModel(8, DateTime(DateTime.now().year,DateTime.now().month + 7,DateTime.now().day + 5 ), 105, 'cm'),
  ChartModel(9, DateTime(DateTime.now().year,DateTime.now().month + 6,DateTime.now().day + 2 ), 110, 'cm'),
  ChartModel(10, DateTime(DateTime.now().year,DateTime.now().month + 7,DateTime.now().day + 5 ), 105, 'cm'),
];

final List<ChartModel> DUMMY_NECK_CHART_DATA = [
  ChartModel(1, DateTime.now(), 45, 'cm'),
  ChartModel(2, DateTime(DateTime.now().year,DateTime.now().month + 1,DateTime.now().day + 2 ), 48, 'cm'),
  ChartModel(3, DateTime(DateTime.now().year,DateTime.now().month + 2,DateTime.now().day + 1 ), 46, 'cm'),
  ChartModel(4, DateTime(DateTime.now().year,DateTime.now().month + 3,DateTime.now().day + 1 ), 47, 'cm'),
  ChartModel(5, DateTime(DateTime.now().year,DateTime.now().month + 4,DateTime.now().day + 5 ), 45, 'cm'),
  ChartModel(6, DateTime(DateTime.now().year,DateTime.now().month + 5,DateTime.now().day + 3 ), 45, 'cm'),
  ChartModel(7, DateTime(DateTime.now().year,DateTime.now().month + 6,DateTime.now().day + 2 ), 48, 'cm'),
  ChartModel(8, DateTime(DateTime.now().year,DateTime.now().month + 7,DateTime.now().day + 5 ), 48, 'cm'),
  ChartModel(9, DateTime(DateTime.now().year,DateTime.now().month + 6,DateTime.now().day + 2 ), 46, 'cm'),
  ChartModel(10, DateTime(DateTime.now().year,DateTime.now().month + 7,DateTime.now().day + 5 ), 47, 'cm'),
];

