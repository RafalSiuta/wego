
import 'dart:collection';

import '../../model/nutrition_model/nutrition_settings_model.dart';

class DataStoreOptionList {

  final List<NutritionSettingsModel> _dataStoreOptionList = [
    NutritionSettingsModel(
        symbol: 'E',
        firstOption: '',
        secondOption: 'option_ones_week',
        value: false
    ),
    NutritionSettingsModel(
        symbol: 'F',
        firstOption: '',
        secondOption: 'option_ones_month',
        value: false
    ),
    NutritionSettingsModel(
        symbol: 'E',
        firstOption: '',
        secondOption: 'option_ones_year',
        value: false
    ),
    NutritionSettingsModel(
        symbol: 'G',
        firstOption: '',
        secondOption: 'option_manually',
        value: false
    ),
  ];

  UnmodifiableListView<NutritionSettingsModel> get dataStoreOptionList {
    return UnmodifiableListView(_dataStoreOptionList);
  }

  int get dataStoreCountingListCounter => _dataStoreOptionList.length;

}