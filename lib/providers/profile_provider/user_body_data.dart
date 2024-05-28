import 'dart:collection';
import '../../model/slider_model/slider_model.dart';

class UserBodyData {

  List<SliderModel> _userBodyData = [
    SliderModel(
        name: 'age',
        unit: 'unit_age',
        minValue: 0,
        maxValue: 150,
        sliderValue: 25),
    SliderModel(
        name: 'weight',
        unit: 'unit_kg',
        minValue: 0,
        maxValue: 300,
        sliderValue: 90),
    SliderModel(
        name: 'height',
        unit: 'unit_cm',
        minValue: 0,
        maxValue: 250,
        sliderValue: 187),
    SliderModel(
        name: 'waist',
        unit: 'unit_cm',
        minValue: 0,
        maxValue: 300,
        sliderValue: 95),
    SliderModel(
        name: 'hips',
        unit: 'unit_cm',
        minValue: 0,
        maxValue: 300,
        sliderValue: 110),
    SliderModel(
        name: 'neck',
        unit: 'unit_cm',
        minValue: 0,
        maxValue: 150,
        sliderValue: 45),
  ];
  UnmodifiableListView<SliderModel> get userBodyData {
    return UnmodifiableListView(_userBodyData);
  }

  set userBodyData(List<SliderModel> value) {
    _userBodyData = value;
  }

  int get userDataListCounter => userBodyData.length;
}
