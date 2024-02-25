import 'dart:collection';
import '../../model/nutrition_model/nutrition_model.dart';
import '../../model/slider_model/slider_model.dart';

class UserNutrition {

  final List<SliderModel> _customNutritionList = [
    SliderModel(
        name: 'protein',
        unit: 'unit_percent',
        minValue: 0,
        maxValue: 100,
        sliderValue: 20),
    SliderModel(
        name: 'carbo',
        unit: 'unit_percent',
        minValue: 0,
        maxValue: 100,
        sliderValue: 45),
    SliderModel(
        name: 'fat',
        unit: 'unit_percent',
        minValue: 0,
        maxValue: 100,
        sliderValue: 35),
  ];

  UnmodifiableListView<SliderModel> get customNutritionList {
    return UnmodifiableListView(_customNutritionList);
  }

  int get customNutritionListCounter {
    return _customNutritionList.length;
  }

  final List<NutritionModel> _defaultNutritionList =  [
     NutritionModel(
        name: 'weight_loss',
        description: 'weight_loss_description',
        protein: 40,
        carbohydrate: 30,
        fat: 30),
    NutritionModel(
        name: 'maintain',
        description: 'maintain_description',
        protein: 30,
        carbohydrate: 40,
        fat: 30),
    NutritionModel(
        name: 'gain_weight',
        description: 'gain_weight_description',
        protein: 35,
        carbohydrate: 50,
        fat: 20),
  ];

  UnmodifiableListView<NutritionModel> get defaultNutritionList {
    return UnmodifiableListView(_defaultNutritionList);
  }

  int get defaultNutritionListCounter {
    return _defaultNutritionList.length;
  }

}