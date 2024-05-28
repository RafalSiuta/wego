import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../data/dummy_chart_data.dart';
import '../../model/calculation_model/calculation_model.dart';
import '../../model/chart_model/chart_model.dart';
import '../../model/choice_model/chip_choice.dart';
import '../../utils/extensions/fit_icons.dart';
import '../../utils/prefs/prefs.dart';
import '../profile_provider/profile_provider.dart';
import '../settings_provider/settings_provider.dart';
import 'package:wego/utils/constans/prefs_keys.dart';
class LogicProvider extends ChangeNotifier {

  LogicProvider( this.profile, this.settings){
    updateCalculationList();
    loadDefaultCharts();
  }

  //TODO:  load chart database in calculations logic

  //TODO: add settings provider calculation options, and add to proxyProvider



  ProfileProvider profile;
  SettingsProvider settings;

  final Prefs _prefs = Prefs();

  List<CalculationModel> _numbersList = [];



  List<ChipChoice> choiceChipList = [
    ChipChoice(name:'chips_indicators' ,category: supplementCategory, value:true),
    ChipChoice(name:'chips_calories', category: mealCategory, value:true),
    ChipChoice(name:'chips_hydro', category: drinkCategory, value:true),
    ChipChoice(name:'chips_strength', category: workoutCategory, value:true),
    ChipChoice(name:'chips_fav', category: isFavoriteCategory, value:true),
  ];
  void chipChoice(int index, bool val){
    choiceChipList[index].value = val;
    _prefs.storeList(chipChoiceListKey, choiceChipList);
    updateCalculationList();
    notifyListeners();
  }

  //STATS
  List<ChartModel> selectedChart = DUMMY_BMI_CHART_DATA;
  String selectedChartCategory = '';

  void loadDefaultCharts(){
    //mainNumbersList.first.isActiveChips = true;
    selectedChartCategory = choiceChipList.first.category!;
    notifyListeners();
  }

  void calculationsChipChoice(int index, bool val) {
    for (int i = 0; i < mainNumbersList.length; i++) {
      mainNumbersList[i].isActiveChips = (i == index) && val;
    }
    selectedChartCategory = mainNumbersList[index].category!;
    notifyListeners();
    // _prefs.storeList(chipChoiceListKey, categoryChartList); // Jeśli używasz zapisu stanu
  }
  //STATS END

  void addToFavorite(CalculationModel calc){
    calc.isFavorite = !calc.isFavorite!;
    updateCalculationList();
    notifyListeners();
  }

  Future<List<CalculationModel>> _calculationsList() async {
    choiceChipList = await _prefs.restoreChipChoiceList(chipChoiceListKey, choiceChipList);

    List<CalculationModel> list = [
      bmiResult(chart: selectedChart),
      bmrResult(chart: selectedChart),
      waterIntakeResult(chart: selectedChart),
      proteinIntakeResult(chart: selectedChart),
      carboIntakeResult(chart: selectedChart),
      fatIntakeResult(chart: selectedChart),
      terResult(chart: selectedChart),
      ymcaResult(chart: selectedChart),
      //aymcaResult(),
      whrResult(chart: selectedChart),
      whtrResult(chart: selectedChart),
      pottonResult(chart: selectedChart),
      pureWeightResult(chart: selectedChart),
      benchResult(chart: selectedChart),
      squatResult(chart: selectedChart),
      deadLiftResult(chart: selectedChart)
    ];

    List<CalculationModel> filteredList = [];

    //DOBRA WERSJA
    for (var chip in choiceChipList) {
      if (chip.value == true) {
        for (var calculation in list) {
          if (calculation.category == chip.category ) {
            if (!filteredList.contains(calculation)) {
              filteredList.add(calculation);
            }
          } else if (calculation.isFavorite == true && chip.category == isFavoriteCategory) {
            if (!filteredList.contains(calculation)) {

              filteredList.add(calculation);
            }
          }
        }
      }
    }

    list.clear();
    list.addAll(filteredList);
    notifyListeners();

    return list;
  }

  void updateCalculationList() async {
    _numbersList = await _calculationsList();
    notifyListeners();
  }

  UnmodifiableListView<CalculationModel> get mainNumbersList {
    return UnmodifiableListView(_numbersList);
  }

  int get numbersListCounter => _numbersList.length;

  //warning color setter:
  Color checkWarning(int status){
    Color? infoColor;
    infoColor ??= Colors.green;
    switch(status){
      case 0:
        infoColor = Colors.green;

        break;
      case 1:
        infoColor = Colors.amber;

        break;
      case 2:
        infoColor = Colors.red;

        break;
    }
    notifyListeners();
    return infoColor;
  }

  //TODO APPLY ONLY FOR CALORIES COUNTING
  double selectedWeight() {
    double? weight = profile.userData.weight;
    if(weight != null){
      switch (settings.weightChoice) {
        case 0:
          weight = weight;
          break;
        case 1:
          weight = pottonResult().value!;
          break;
        case 2:
          weight = lorenzResult().value!;
          break;
        case 3:
          weight = pureWeightResult().value!;
          break;
        default:
          weight = profile.userData.weight!;
      }
    }else{
      weight = 0;
    }

    notifyListeners();
    return weight;
  }
  void errorCall(CalculationModel model, [String? errorMessage]) {
    // Opcjonalne logowanie oryginalnych wartości
    print("Error in CalculationModel: ${model.value} : ${model.shortTitle} $errorMessage" ); // Usuń to w produkcji lub użyj dedykowanego loggera

    model.value = null;
    model.unit = 'error_null';
    model.description = 'error_user';
    model.infoColor = checkWarning(2);
    notifyListeners();
  }
  CalculationModel bmiResult({List<ChartModel>? chart}) {
    CalculationModel bmi = CalculationModel();

    double? weight = profile.userData.weight;
    double? height = profile.userData.height;

    try {
      if (weight != null && weight != 0 && height != null && height != 0) {
        double bmiValue = weight / pow((height / 100), 2);
        if (bmiValue < 18.5) {
          bmi.unit = 'bmi_underweight';
          bmi.description = 'bmi_underweight_description';
          bmi.infoColor = checkWarning(2);
        } else if (bmiValue <= 24.99) {
          bmi.unit = 'bmi_healthy_weight';
          bmi.description = 'bmi_healthy_weight_description';
          bmi.infoColor = checkWarning(0);
        } else if (bmiValue < 30) {
          bmi.unit = 'bmi_overweight';
          bmi.description = 'bmi_overweight_description';
          bmi.infoColor = checkWarning(1);
        } else {
          bmi.unit = 'bmi_obese';
          bmi.description = 'bmi_obese_description';
          bmi.infoColor = checkWarning(2);
        }
        bmi.value = bmiValue;
      } else {
        throw new Exception('Invalid input: Weight or height cannot be zero or null.');
      }
    } catch (e) {
      errorCall(bmi);
    } finally {
      bmi.symbol = FitIcons.bmi;
      bmi.title = 'bmi_title';
      bmi.shortTitle = 'BMI';
      bmi.longDescription = 'bmi_long_description';
      bmi.formulaMale = 'BMI = W / H ²';
      bmi.formulaFemale = "";
      bmi.chartList = chart;
      bmi.imagePath = 'images/bmi.png';
      bmi.category = supplementCategory;
      bmi.isFavorite = true;
      bmi.isActiveChips = true;
    }

    notifyListeners();
    return bmi;
  }

  CalculationModel bmrResult({List<ChartModel>? chart}) {

    CalculationModel bmr = CalculationModel();

    try {
      double? weight = selectedWeight();
      double? height = profile.userData.height;
      double? age = profile.userData.age;

      if (weight != null && weight != 0 && height != null && height != 0 && age != null && age != 0) {
        if (profile.userData.gender == true) {
          bmr.value = 66.47 + (13.75 * weight) + (5 * height) - (6.75 * age);
        } else {
          bmr.value = 665.09 + (9.56 * weight) + (1.85 * height) - (4.67 * age);
        }
      } else {
        throw Exception('Invalid input');
      }
    } catch (e) {
      errorCall(bmr); // Załóżmy, że funkcja errorHandling zarządza błędami
    } finally {
      // Statyczne właściwości ustawiane niezależnie od wyniku bloku try-catch
      bmr.symbol = FitIcons.bmr;
      bmr.shortTitle = 'BMR';
      bmr.title = 'bmr_title';
      bmr.unit = 'bmr_unit';
      bmr.description = 'bmr_description';
      bmr.longDescription = 'bmr_long_description';
      bmr.formulaMale = 'BMR = 66.47 + (13.75 * W ) + (5 * H) - (6.75 * A)';
      bmr.formulaFemale =
      'BMR = 665.09 + (9.56 * W ) + (1.85 * H) - (4.67 * A)';
      bmr.chartList = chart; //bmrChart;
      bmr.imagePath = 'images/bmr.png';//imagePath('male_food', 'female_food');
      bmr.infoColor = checkWarning(0);
      bmr.category = mealCategory;
      bmr.isFavorite = false;
      bmr.isActiveChips = false;
      notifyListeners();
    }
    notifyListeners();
    return bmr;
  }

  CalculationModel terResult({List<ChartModel>? chart}) {
    CalculationModel ter = CalculationModel();
    try {
      double? weight = selectedWeight();
      double? height = profile.userData.height;
      double? age = profile.userData.age;

      if (weight != null && weight != 0 && height != null && height != 0 && age != null && age != 0) {
        double terValue;
        if (profile.userData.gender == true) {
          terValue = 66.47 + (13.75 * weight) + (5 * height) - (6.75 * age);
        } else {
          terValue = 665.09 + (9.56 * weight) + (1.85 * height) - (4.67 * age);
        }
        switch (profile.userData.activity) {
          case 0:
            ter.value = terValue * 1.2;
            break;
          case 1:
            ter.value = terValue * 1.4;
            break;
          case 2:
            ter.value = terValue * 1.6;
            break;
          case 3:
            ter.value = terValue * 1.75;
            break;
          case 4:
            ter.value = terValue * 1.9;
            break;
          default:
            throw Exception('Invalid activity level');
        }
      } else {
        throw Exception('Invalid input: Weight or height cannot be zero or null.');
      }

    } catch (e) {
      errorCall(ter); // Ensure errorCall handles all required properties like setting ter.value to null or a default error value.
    } finally {
      // Set static values
      ter.symbol = FitIcons.ter;
      ter.shortTitle = 'TER';
      ter.title = 'ter_title';
      ter.unit = 'ter_unit';
      ter.description = 'ter_description';
      ter.longDescription = 'ter_long_description';
      ter.formulaMale = 'BMR = 66.47 + (13.75 * W ) + (5 * H) - (6.75 * A) \n TER = BMR * AC';
      ter.formulaFemale = 'BMR = 665.09 + (9.56 * W ) + (1.85 * H) - (4.67 * A) \n TER = BMR * AC';
      ter.chartList = chart;
      ter.imagePath = 'images/ter.png';
      ter.category = mealCategory;
      ter.isFavorite = false;
      ter.isActiveChips = false;
      notifyListeners();
    }
    notifyListeners();
    return ter;
  }
  //
  CalculationModel ymcaResult({List<ChartModel>? chart}) {
    CalculationModel ymca = CalculationModel();

      try {

        double? waist = profile.userData.waist;
        double? weight = profile.userData.weight;
        bool? gender = profile.userData.gender;



        if (weight != null && weight != 0 && waist != null && waist != 0 && gender != null) {

          double baseValue = gender ? 98.42 : 76.76;
          double ymcaValue = ((1.634 * waist - 0.1804 * weight - baseValue) / 2.2 * weight) / 100;


          if (gender == true) {
            if (ymcaValue >= 3 && ymcaValue <= 5) {
              ymca.unit = 'ymca_essential_fat';
              ymca.infoColor = checkWarning(0);
            } else if (ymcaValue >= 6 && ymcaValue <= 14) {
              ymca.unit = 'ymca_athletes';
              ymca.infoColor = checkWarning(0);
            } else if (ymcaValue > 14 && ymcaValue <= 18) {
              ymca.unit = 'ymca_fitness';
              ymca.infoColor = checkWarning(0);
            } else if (ymcaValue > 18 && ymcaValue <= 25) {
              ymca.unit = 'ymca_average';
              ymca.infoColor = checkWarning(1);
            } else if (ymcaValue > 25) {
              ymca.unit = 'ymca_obese';
              ymca.infoColor = checkWarning(2);
            }

          } else if (ymcaValue >= 10 && ymcaValue <= 14) {
            ymca.unit = 'ymca_essential_fat';
            ymca.infoColor = checkWarning(0);
          } else if (ymcaValue > 14 && ymcaValue <= 21) {
            ymca.unit = 'ymca_athletes';
            ymca.infoColor = checkWarning(0);
          } else if (ymcaValue > 21 && ymcaValue <= 25) {
            ymca.unit = 'ymca_fitness';
            ymca.infoColor = checkWarning(0);
          } else if (ymcaValue > 25 && ymcaValue <= 32) {
            ymca.unit = 'ymca_average';
            ymca.infoColor = checkWarning(1);
          } else if (ymcaValue > 32) {
            ymca.unit = 'ymca_obese';
            ymca.infoColor = checkWarning(2);
          }
          ymca.value = ymcaValue;
        } else {
          throw Exception('Invalid input');
        }
      }catch(e) {
        errorCall(ymca);
      } finally {
        ymca.symbol = FitIcons.ymca;
        ymca.title = 'ymca_title';
        ymca.shortTitle = 'YMCA';
        ymca.description = 'ymca_description';
        ymca.longDescription = 'ymca_long_description';
        ymca.formulaMale =
        'YMCA = ((1.634 * Wa - 0.1804 * W - 98.42) / 2.2 * W) / 100 ';
        ymca.formulaFemale =
        'YMCA = ((1.634 * Wa - 0.1804 * W - 76.76) / 2.2 * W) / 100  ';
        ymca.chartList = chart;
        ymca.imagePath = 'images/ymca.png';
        ymca.category = supplementCategory;
        ymca.isFavorite = false;
        ymca.isActiveChips = false;

      }
    notifyListeners();
    return ymca;
  }
  //
  // CalculationModel aymcaResult({List<ChartModel>? chart}) {
  //   CalculationModel aymca = CalculationModel();
  //   try {
  //     if (profile.userData.gender == true) {
  //       aymca.value = 495 /
  //           (1.0324 -
  //               .19077 * (log(profile.userData.waist! - profile.userData.neck!) / log(10)) +
  //               .15456 * (log(profile.userData.height!) / log(10))) -
  //           450;
  //     } else {
  //       aymca.value = 495 /
  //           (1.29579 -
  //               .35004 * (log(profile.userData.waist! + profile.userData.hips! - profile.userData.neck!) / log(10)) +
  //               .22100 * (log(profile.userData.height!) / log(10))) -
  //           450;
  //     }
  //     aymca.value = (aymca.value! * profile.userData.weight!) / 100;
  //     aymca.value = aymca.value! * 0.45359237;
  //   } catch (e) {
  //     aymca.value = 0;
  //   } finally {
  //     if (profile.userData.gender == true) {
  //       if (aymca.value! >= 3 && aymca.value! <= 5) {
  //         aymca.unit = 'aymca_essential_fat';
  //         aymca.infoColor = checkWarning(0);
  //       } else if (aymca.value! >= 6 && aymca.value! <= 14) {
  //         aymca.unit = 'aymca_athletes';
  //         aymca.infoColor = checkWarning(0);
  //       } else if (aymca.value! > 14 && aymca.value! <= 18) {
  //         aymca.unit = 'aymca_fitness';
  //         aymca.infoColor = checkWarning(0);
  //       } else if (aymca.value! > 18 && aymca.value! <= 25) {
  //         aymca.unit = 'aymca_average';
  //         aymca.infoColor = checkWarning(1);
  //       } else if (aymca.value! > 25) {
  //         aymca.unit = 'aymca_obese';
  //         aymca.infoColor = checkWarning(2);
  //       }
  //     } else {
  //       if (aymca.value! >= 10 && aymca.value! <= 14) {
  //         aymca.unit = 'aymca_essential fat';
  //         aymca.infoColor = checkWarning(0);
  //       } else if (aymca.value! > 14 && aymca.value! <= 21) {
  //         aymca.unit = 'aymca_athletes';
  //         aymca.infoColor = checkWarning(0);
  //       } else if (aymca.value! > 21 && aymca.value! <= 25) {
  //         aymca.unit = 'aymca_fitness';
  //         aymca.infoColor = checkWarning(0);
  //       } else if (aymca.value! > 25 && aymca.value! <= 32) {
  //         aymca.unit = 'aymca_average';
  //         aymca.infoColor = checkWarning(1);
  //       } else if (aymca.value! > 32) {
  //         aymca.unit = 'aymca_obese';
  //         aymca.infoColor = checkWarning(2);
  //       }
  //     }
  //     aymca.symbol = FitIcons.ymca;
  //     aymca.title = 'aymca_title';
  //     aymca.shortTitle = 'YMCA navy';
  //     aymca.description = 'aymca_description';
  //     aymca.longDescription = 'aymca_long_description';
  //     aymca.formulaMale =
  //     'BF = 495 / (1.0324 - 0.19077 * (log(Wa - N) / log(10)) + 0.15456 * (log(H) / log(10))) - 450 \n BF = ((BF * W) / 100)  * 0.45359237';
  //     aymca.formulaFemale =
  //     'BF = 495 / (1.29579 - 0.35004 * (log(Wa[cm] + Hi - N) / log(10)) + 0.22100 * (log(H) / log(10))) - 450 \n BF = ((BF * W) / 100)  * 0.45359237 ';
  //     aymca.chartList = chart;
  //     aymca.imagePath = 'images/ymca.png';//imagePath('male_index3', 'female_index3');
  //     aymca.category = supplementCategory;
  //     aymca.isFavorite = false;
  //     aymca.isActiveChips = false;
  //
  //   }
  //   notifyListeners();
  //   return aymca;
  // }
  //
  CalculationModel whrResult({List<ChartModel>? chart}) {

    CalculationModel whr = CalculationModel();
    try {
      double? hips = profile.userData.hips;
      double? waist = profile.userData.waist;

      if(hips != null && hips != 0 && waist != null && waist != 0){

        double whrValue = waist / hips;
        whr.value = whrValue;


        if (profile.userData.gender == true) {
          if (whrValue <= 0.95) {
            whr.unit = 'whr_good';
            whr.description = 'whr_good_description';
            whr.infoColor = checkWarning(0);
          } else if (whrValue <= 0.99) {
            whr.unit = 'whr_average';
            whr.description = 'whr_average_description';
            whr.infoColor = checkWarning(1);
          } else {
            whr.unit = 'whr_high';
            whr.description = 'whr_high_description';
            whr.infoColor = checkWarning(2);
          }
        } else {
          if (whrValue <= 0.80) {
            whr.unit = 'whr_good';
            whr.description = 'whr_good_description';
            whr.infoColor = checkWarning(0);
          } else if (whrValue <= 0.84) {
            whr.unit = 'whr_average';
            whr.description = 'whr_average_description';
            whr.infoColor = checkWarning(1);
          } else {
            whr.unit = 'whr_high';
            whr.description = 'whr_high_description';
            whr.infoColor = checkWarning(2);
          }
        }
      }else{
        //throw Exception('Invalid input');
        errorCall(whr,);
      }

    } catch (e) {
      errorCall(whr, "WHR value ${whr.value.toString()}");
    } finally {

      whr.symbol = FitIcons.whr;
      whr.title = 'whr_title';
      whr.shortTitle = 'WHR';
      whr.longDescription = 'whr_long_description';
      whr.formulaMale = 'WHR = Wa / Hi ';
      whr.formulaFemale = "";
      whr.chartList = chart;
      whr.imagePath = imagePath('whr', 'whr_female');
      whr.category = supplementCategory;
      whr.isFavorite = false;
      whr.isActiveChips = false;

    }
    notifyListeners();
    return whr;
  }
  //
  CalculationModel whtrResult({List<ChartModel>? chart}) {
    CalculationModel whtr = CalculationModel();
    try {
      double? height = profile.userData.height;
      double? waist = profile.userData.waist;
      bool? isMale = profile.userData.gender;

      if(height != null && height != 0 && waist != null && waist != 0 && isMale != null){
        double whtrValue = waist / height;
        double upperBound = isMale ? 0.53 : 0.49; // example thresholds, adjust as needed
        if (whtrValue < 0.35) {
          whtr.unit = 'whtr_extremely_slim';
          whtr.description = 'whtr_extremely_slim_description';
          whtr.infoColor = checkWarning(2);
        } else if (whtrValue <= upperBound) {
          whtr.unit = 'whtr_slim';
          whtr.description = 'whtr_slim_description';
          whtr.infoColor = checkWarning(1);
        } else if (whtrValue <= 0.57) {
          whtr.unit = 'whtr_healthy';
          whtr.description = 'whtr_healthy_description';
          whtr.infoColor = checkWarning(0);
        } else {
          whtr.unit = 'whtr_obese';
          whtr.description = 'whtr_obese_description';
          whtr.infoColor = checkWarning(2);
        }
        whtr.value = whtrValue;
      }else{
        throw Exception('Invalid input');
      }

    } catch (e) {
      errorCall(whtr);
    } finally {


      whtr.symbol = FitIcons.whtr;
      whtr.title = 'whtr_title';
      whtr.shortTitle = 'WHTR';
      whtr.longDescription = 'whtr_long_description';
      whtr.formulaMale = 'WHTR = Wa / H * 100';
      whtr.formulaFemale = '';
      whtr.chartList = chart;
      whtr.imagePath = imagePath('whtr', 'whtr_female');
      whtr.category = supplementCategory;
      whtr.isFavorite = false;
      whtr.isActiveChips = false;
    }
    notifyListeners();
    return whtr;
  }
  //
  CalculationModel pottonResult({List<ChartModel>? chart}) {
    CalculationModel potton = CalculationModel();
    try {
      double? height = profile.userData.height;
      bool? isMale = profile.userData.gender;

      if(height != null && height != 0 && isMale != null){

        double baseValue = isMale ? 20 : 10;
        double pottonValue =  height - 100 - ((height - 100) / baseValue);

        potton.value = pottonValue;
      }else{
        throw Exception("invalid input");
      }

    } catch (e) {
      errorCall(potton,e.toString());
    } finally {
      potton.symbol = FitIcons.potton;
      potton.unit = 'potton_unit';
      potton.description = 'potton_description';
      potton.title = 'potton_title';
      potton.shortTitle = 'Potton';
      potton.longDescription = 'potton_long_description';
      potton.formulaMale = 'Potton = H - 100 - ((H  - 100) / 10)';
      potton.formulaFemale = 'Potton = H  - 100 - ((H  - 100) / 20)';
      potton.chartList = chart;
      potton.imagePath =
          'images/food_1.png';//imagePath('male_weight_potton', 'female_weight_potton');
      potton.infoColor = checkWarning(0);
      potton.category = supplementCategory;
      potton.isFavorite = false;
      potton.isActiveChips = false;
    }
    notifyListeners();
    return potton;
  }
  //
  CalculationModel lorenzResult({List<ChartModel>? chart}) {
    CalculationModel lorenz = CalculationModel();
    try {
      double? height = profile.userData.height;
      bool? isMale = profile.userData.gender;

      if(height != null && height != 0 && isMale != null) {
        double baseValue = isMale ? 4 : 2;
        lorenz.value = height - 100 - ((height - 150) / baseValue);
      }else{
        errorCall(lorenz,'invalid input height value cannot be zero or null');
      }
    } catch (e) {
      errorCall(lorenz,e.toString());
    } finally {
      lorenz.symbol = FitIcons.lorenz;
      lorenz.unit = 'lorenz_unit';
      lorenz.description = 'lorenz_description';
      lorenz.title = 'lorenz_title';
      lorenz.shortTitle = 'Lorenz';
      lorenz.longDescription = 'lorenz_long_description';
      lorenz.formulaMale = 'Lorenz = H - 100 - ((H  - 150) / 2)';
      lorenz.formulaFemale = 'Lorenz = H - 100 - ((H  - 150) / 4)';
      lorenz.chartList = chart;
      lorenz.imagePath = 'images/pure_weight.png';
      lorenz.infoColor = checkWarning(0);
      lorenz.category  = supplementCategory;
      lorenz.isFavorite = false;
      lorenz.isActiveChips = false;
    }
    notifyListeners();
    return lorenz;
  }
  //
  CalculationModel pureWeightResult({List<ChartModel>? chart}) {
    CalculationModel leanWeight = CalculationModel();

    try {
      double? fatWeight;
      double? weight = profile.userData.weight;
      double? waist = profile.userData.waist;
      double? height = profile.userData.height;
      double? neck = profile.userData.neck;
      double? hips = profile.userData.hips;
      bool? isMale = profile.userData.gender;
      // Helper function to calculate fat weight based on gender
      // double calculateFatWeight(double weight, double waist, double height, double neck, double hips, bool isMale) {
      //   double baseValue = isMale ? 4 : 2;  // Adjust base value based on gender
      //   double logBase = log(10);
      //   double waistNeck = isMale ? waist - neck : waist + hips - neck;
      //   double fatWeight = 495 / (1.29579 - 0.35004 * (log(waistNeck) / logBase) + 0.221 * (log(height) / logBase)) - 450;
      //   return (fatWeight * weight) / 100 * 0.45359237;  // Convert to kilograms if necessary
      // }

      if(weight != null && weight > 0 && height != null && height > 0 &&
          waist != null && waist > 0 && neck != null && neck > 0 &&
          hips != null && hips > 0 && isMale != null){

        // double fatWeight = calculateFatWeight(weight, waist, height, neck, hips, isMale);
        // leanWeight.value = weight - fatWeight;

        if (isMale == true) {
          fatWeight = 495 /
              (1.0324 - .19077 * (log(waist - neck) / log(10)) + .15456 * (log(height) / log(10))) - 450;
        } else {
          fatWeight = 495 /
              (1.29579 - .35004 * (log(waist + hips - neck) / log(10)) + .22100 * (log(height) / log(10))) - 450;
        }
        fatWeight = (fatWeight * weight) / 100;
        fatWeight *= 0.45359237;
        leanWeight.value = weight - fatWeight;
      }else{
        errorCall(leanWeight,'invalid input');
      }

    } catch (e) {
      errorCall(leanWeight,e.toString());
    } finally {
      leanWeight.symbol = FitIcons.low_fat_weight;
      leanWeight.unit = 'pureweight_unit';
      leanWeight.description = 'pureweight_description';
      leanWeight.title = 'pureweight_title';
      leanWeight.shortTitle = 'LowFatWeight';
      leanWeight.longDescription = 'pureweight_long_description';
      leanWeight.formulaMale = 'LowFatWeight = W - BF';
      leanWeight.formulaFemale = '';
      leanWeight.chartList = chart;
      leanWeight.imagePath = 'images/pure_weight.png';//imagePath('male_weight_fat', 'female_weight_fat');
      leanWeight.category = supplementCategory;
      leanWeight.infoColor = checkWarning(0);
      leanWeight.isFavorite = false;
      leanWeight.isActiveChips = false;
    }
    notifyListeners();
    return leanWeight;
  }

  CalculationModel waterIntakeResult({List<ChartModel>? chart}) {
    CalculationModel water = CalculationModel();
    double selectWeight = selectedWeight();

    try {
      water.value = (selectWeight * 30) / 1000;

    } catch (e) {
      errorCall(water,e.toString());
    } finally {
      water.symbol = FitIcons.water_intake;
      water.shortTitle = 'H2O';
      water.title = 'water_title';
      water.unit = 'water_unit';
      water.description = 'water_description';
      water.longDescription = 'water_long_description';
      water.formulaMale = 'H2O = (W * 30) / 1000';
      water.formulaFemale = "";
      water.chartList = chart;
      water.imagePath = 'images/water.png';//imagePath('male_water', 'female_water');
      water.infoColor = checkWarning(0);
      water.category = drinkCategory;
      water.isFavorite = false;
      water.isActiveChips = false;
    }
    notifyListeners();
    return water;
  }
  //
  CalculationModel proteinIntakeResult({List<ChartModel>? chart}) {
    CalculationModel proteinIntake = CalculationModel();
    double selectWeight = selectedWeight();
    double bmr;

    print('PROTEIN VALUES LOGIC');
    try {
      double? height = profile.userData.height;
      double? age = profile.userData.age;
      double? proteinPercent = profile.userData.proteinPercent;

      double? proteinIntakeValue = proteinIntake.value;

      if(height != null && height != 0 && age != null && age != 0 && proteinPercent != null && proteinPercent != 0){
        if (profile.userData.gender == true) {
          bmr = 66.47 + (13.75 * selectWeight) + (5 * height) - (6.75 * age);
        } else {
          bmr = 665.09 + (9.56 * selectWeight) + (1.85 * height) - (4.67 * age);
        }
        if (settings.isMaxKcal == true) {
          switch (profile.userData.activity) {
            case 0:
              bmr = bmr * 1.2;
              break;
            case 1:
              bmr = bmr * 1.4;
              break;
            case 2:
              bmr = bmr * 1.6;
              break;
            case 3:
              bmr = bmr * 1.75;
              break;
            case 4:
              bmr = bmr * 1.9;
              break;
          }
        }
        if (settings.isProteinKcal == true) {
          proteinIntake.unit = "unit_kcal";
          proteinIntakeValue = (bmr * proteinPercent) / 100;

        } else {
          proteinIntake.unit = "unit_gram";
          proteinIntakeValue = (bmr * proteinPercent) / 100;
          proteinIntake.value = proteinIntakeValue / 4;

        }


      }else{
        String msg = 'INVALID INPUT Protein protein percent ${profile.userData.proteinPercent} carb percent ${profile.userData.carbPercent} fat percent  ${profile.userData.fatPercent}  ${profile.userData.height} age: ${profile.userData.age} sel weight ${selectWeight} isMaxKcal: ${settings.isMaxKcal} isProtKcal ${settings.isProteinKcal}';
        errorCall(proteinIntake,msg);
      }
      notifyListeners();
    } catch (e) {
      errorCall(proteinIntake,e.toString());
    } finally {
      proteinIntake.symbol = FitIcons.protein;
      proteinIntake.title = "protein_title";
      proteinIntake.shortTitle = "PROTEIN";
      proteinIntake.description = "protein_description";
      proteinIntake.longDescription = "protein_long_description";
      proteinIntake.formulaMale = "P = (K * M) / 100";
      proteinIntake.formulaFemale = "";
      proteinIntake.chartList = chart;
      proteinIntake.imagePath = 'images/protein.png';
      proteinIntake.infoColor = checkWarning(0);
      proteinIntake.category = mealCategory;
      proteinIntake.isFavorite = false;
      proteinIntake.isActiveChips = false;
    }
    notifyListeners();
    return proteinIntake;
  }
  //
  CalculationModel carboIntakeResult({List<ChartModel>? chart}) {

    CalculationModel carboIntake = CalculationModel();
    double? bmr = bmrResult().value;

    double? carboPercent = profile.userData.carbPercent;

    double? carboIntakeValue = carboIntake.value;

    try {

      if(bmr != null && bmr > 0 && carboPercent != null && carboPercent > 0){
        if (settings.isMaxKcal == true) {
          switch (profile.userData.activity) {
            case 0:
              bmr = bmr * 1.2;
              break;
            case 1:
              bmr = bmr * 1.4;
              break;
            case 2:
              bmr = bmr * 1.6;
              break;
            case 3:
              bmr = bmr * 1.75;
              break;
            case 4:
              bmr = bmr * 1.9;
              break;
          }
        }
        if (settings.isCarboKcal == true) {
          carboIntake.unit = "unit_kcal";
          carboIntake.value = (bmr * carboPercent) / 100;
        } else {
          carboIntake.unit = "unit_gram";
          carboIntakeValue = (bmr * carboPercent) / 100;
          carboIntake.value = carboIntakeValue / 4;
        }
      }else{
        errorCall(carboIntake,e.toString());
      }

    } catch (e) {
      errorCall(carboIntake,e.toString());
    } finally {
      carboIntake.symbol = FitIcons.carbo;
      carboIntake.title = "carbo_title";
      carboIntake.shortTitle = "CARBO";
      carboIntake.description = "carbo_description";
      carboIntake.longDescription = "carbo_long_description";
      carboIntake.formulaMale = "C = (K * M) / 100";
      carboIntake.formulaFemale = "";
      carboIntake.chartList = chart;
      carboIntake.imagePath = 'images/carbo.png';//imagePath('male_food', 'female_food_carbo');
      carboIntake.infoColor = checkWarning(0);
      carboIntake.category = mealCategory;
      carboIntake.isFavorite = false;
      carboIntake.isActiveChips = false;
    }
    notifyListeners();
    return carboIntake;
  }
  //
  CalculationModel fatIntakeResult({List<ChartModel>? chart}) {

    CalculationModel fatIntake = CalculationModel();

    double? bmr = bmrResult().value;

    double? fatPercent = profile.userData.fatPercent;

    double? fatIntakeValue = fatIntake.value;

    try {
      if(bmr != null && bmr > 0 && fatPercent != null && fatPercent > 0){
        if (settings.isMaxKcal == true) {
          switch (profile.userData.activity) {
            case 0:
              bmr = bmr * 1.2;
              break;
            case 1:
              bmr = bmr * 1.4;
              break;
            case 2:
              bmr = bmr * 1.6;
              break;
            case 3:
              bmr = bmr * 1.75;
              break;
            case 4:
              bmr = bmr * 1.9;
              break;
          }
        }else{
          errorCall(fatIntake,e.toString());
        }

        if (settings.isFatKcal == true) {
          fatIntake.unit = "unit_kcal";
          fatIntake.value = (bmr * fatPercent) / 100;
        } else {
          fatIntake.unit = "unit_gram";
          fatIntakeValue = (bmr * fatPercent) / 100;
          fatIntake.value = fatIntakeValue / 4;
        }
      }

    } catch (e) {
      errorCall(fatIntake,e.toString());
    } finally {
      fatIntake.symbol = FitIcons.fat;
      fatIntake.title = "fat_title";
      fatIntake.shortTitle = "FAT";
      fatIntake.description = "fat_description";
      fatIntake.longDescription = "fat_long_description";
      fatIntake.formulaMale = "F = (K * M) / 100";
      fatIntake.formulaFemale = "";
      fatIntake.chartList = chart;
      fatIntake.imagePath = 'images/fats.png';
      fatIntake.infoColor = checkWarning(0);
      fatIntake.category = mealCategory;
      fatIntake.isFavorite = false;
      fatIntake.isActiveChips = false;
    }
    notifyListeners();
    return fatIntake;
  }
  //
  // CalculationModel maxHrResult({List<ChartModel> chart}) {
  //   num selectWeight = selectedWeight();
  //
  //   try {
  //     if (gender == true) {
  //       //male
  //       _maxHr.value = 210 - (0.5 * age) - (0.022 * selectWeight) + 4;
  //     } else {
  //       //female
  //       _maxHr.value = 210 - (0.5 * age) - (0.022 * selectWeight);
  //     }
  //   } catch (e) {
  //     _maxHr.value = 0;
  //   } finally {
  //     _maxHr.symbol = 'Q';
  //     _maxHr.shortTitle = 'MaxHR';
  //     _maxHr.title = 'maxhr_title';
  //     _maxHr.unit = 'maxhr_unit';
  //     _maxHr.description = 'maxhr_description';
  //     _maxHr.longDescription = 'maxhr_long_description';
  //     _maxHr.formulaMale = 'maxHR = 210 - (0.5 * A) - (0.022 * W) + 4';
  //     _maxHr.formulaFemale = 'maxHR = 210 - (0.5 * A) - (0.022 * W) ';
  //     _maxHr.chartList = chart;
  //     _maxHr.imagePath = 'images/food_1.png';//imagePath('male_run', 'female_run');
  //     displayColorValue = colorLightingColorDark;
  //   }
  //   return _maxHr;
  // }
  //
  CalculationModel benchResult({List<ChartModel>? chart}) {
    CalculationModel maxBenchPress = CalculationModel();
    double? benchPower = profile.userData.benchPressPower;
    try {
      if(benchPower != null && benchPower > 0){
        maxBenchPress.value = (benchPower * 1.1307) + 0.6998;
      }else{
        errorCall(maxBenchPress,e.toString());
      }

    } catch (e) {
      errorCall(maxBenchPress,e.toString());
    } finally {
      maxBenchPress.symbol = FitIcons.bench_press;
      maxBenchPress.shortTitle = 'Max Bench';
      maxBenchPress.title = 'maxbench_title';
      maxBenchPress.unit = 'maxbench_unit';
      maxBenchPress.description = 'maxbench_description';
      maxBenchPress.longDescription = 'maxbench_long_description';
      maxBenchPress.formulaMale = 'Bp = (W * 1.1307) + 0.6998';
      maxBenchPress.formulaFemale = "";
      maxBenchPress.chartList = chart;
      maxBenchPress.imagePath = 'images/workout_dude.png';//imagePath('male_bench', 'female_bench');
      maxBenchPress.infoColor = checkWarning(0);
      maxBenchPress.category = workoutCategory;
      maxBenchPress.isFavorite = false;
      maxBenchPress.isActiveChips = false;
    }
    notifyListeners();
    return maxBenchPress;
  }
  //
  CalculationModel squatResult({List<ChartModel>? chart}) {
    CalculationModel maxSquat = CalculationModel();
    double? squatPower = profile.userData.squatPower;
    try {
      if(squatPower != null && squatPower > 0){
        maxSquat.value = (squatPower * 1.09703) + 14.2546;
      }else{
        errorCall(maxSquat,e.toString());
      }

    } catch (e) {
      errorCall(maxSquat,e.toString());
    } finally {
      maxSquat.symbol = FitIcons.squat;
      maxSquat.shortTitle = 'Max Squat';
      maxSquat.title = 'maxsquat_title';
      maxSquat.unit = 'maxsquat_unit';
      maxSquat.description = 'maxsquat_description';
      maxSquat.longDescription = 'maxsquat_long_description';
      maxSquat.formulaMale = 'Ms = (W * 1.09703) + 14.2546';
      maxSquat.formulaFemale = "";
      maxSquat.chartList = chart;
      maxSquat.imagePath = 'images/workout_dude.png';//imagePath('male_squat', 'female_squat');
      maxSquat.infoColor = checkWarning(0);
      maxSquat.category = workoutCategory;
      maxSquat.isFavorite = false;
      maxSquat.isActiveChips = false;
    }
    notifyListeners();
    return maxSquat;
  }
  //
  CalculationModel deadLiftResult({List<ChartModel>? chart}) {
    CalculationModel maxDeadLift = CalculationModel();
    double? deadliftPower = profile.userData.deadLiftPower;
    try {
      if(deadliftPower != null && deadliftPower > 0){
        maxDeadLift.value = (deadliftPower * 1.09703) + 14.2546;
      }else{
        errorCall(maxDeadLift,e.toString());
      }

    } catch (e) {
      errorCall(maxDeadLift,e.toString());
    } finally {
      maxDeadLift.symbol = FitIcons.deadlift;
      maxDeadLift.shortTitle = 'Max DeadLift';
      maxDeadLift.title = 'maxdeadlift_title';
      maxDeadLift.unit = 'maxdeadlift_unit';
      maxDeadLift.description = 'maxdeadlift_description';
      maxDeadLift.longDescription = 'maxdeadlift_long_description';
      maxDeadLift.formulaMale = 'Md = (W * 1.09703) + 14.2546';
      maxDeadLift.formulaFemale = "";
      maxDeadLift.chartList = chart;
      maxDeadLift.imagePath = imagePath('deadlift_male', 'deadlift_girl');
      maxDeadLift.infoColor  = checkWarning(0);
      maxDeadLift.category = workoutCategory;
      maxDeadLift.isFavorite = false;
      maxDeadLift.isActiveChips = false;
    }
    notifyListeners();
    return maxDeadLift;
  }

  String imagePath(String maleImagePath, String femaleImagePath) {
    if (profile.userData.gender == true) {
      return 'images/$maleImagePath.png';
    } else {
      return 'images/$femaleImagePath.png';
    }
  }


}