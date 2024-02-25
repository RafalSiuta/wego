import 'dart:collection';

import '../../model/slider_model/slider_model.dart';

class UserActivityPowerData {

  List<SliderModel> _activityPowerData = [
    SliderModel(
        name: 'bench_press',
        unit: 'unit_kg',
        minValue: 0,
        maxValue: 500,
        sliderValue: 100),
    SliderModel(
        name: 'squat',
        unit: 'unit_kg',
        minValue: 0,
        maxValue: 500,
        sliderValue: 120),
    SliderModel(
        name: 'dead_lift',
        unit: 'unit_kg',
        minValue: 0,
        maxValue: 500,
        sliderValue: 120),
  ];

  UnmodifiableListView<SliderModel> get activityPowerData {
    return UnmodifiableListView(_activityPowerData);
  }

  int get activityPowerListCounter => _activityPowerData.length;

  set activityPowerData(List<SliderModel> value) {
    _activityPowerData = value;
  }
}