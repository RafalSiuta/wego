
import 'package:flutter/material.dart';

const workoutCategory = "CALENDAR_WORKOUT_CATEGORY";
const mealCategory = "CALENDAR_MEAL_CATEGORY";
const drinkCategory = "CALENDAR_DRINK_CATEGORY";
const supplementCategory = "CALENDAR_SUPPLEMENT_CATEGORY";
const isFavoriteCategory = "MY_FAVORITE_CARD_CATEGORY";

class ChipChoiceModel{
  ChipChoiceModel({this.category, this.value, this.name});
  String? name;
  String? category;
  bool? value;

  Map<String, dynamic> toMap() => {
    'name': name,
    'category': category,
    'value': value,
  };

  ChipChoiceModel.fromJson(Map<String, dynamic> json)
      : value = json['value'] as bool,
        name = json['name'],
        category = json['category'];
}

class CalculationModel {
  int? id;
  String? title;
  String? shortTitle;
  String? category;
  bool? isFavorite;
  double? value;
  String? unit;
  String? description;
  String? imagePath;

  CalculationModel({this.id,
    this.title,
    this.shortTitle,
    this.unit,
    this.description,
    this.value,
    this.isFavorite = false,
    this.imagePath = '',
    this.category
  });

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'title': title,
        'short_title': shortTitle,
        'value': value,
        'unit': unit,
        'description': description,
        'is_favorite': isFavorite,
        'img_path': imagePath,
      };

  CalculationModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        shortTitle = json['short_title'],
        value = json['value'] as double,
        unit = json['unit'],
        description = json['description'],
        isFavorite = json['is_favorite'] as bool,
        imagePath = json['img_path'];
}

class LogicNote extends ChangeNotifier{


  List<ChipChoiceModel> choiceChipList = [
    ChipChoiceModel(name:'indicators' ,category: supplementCategory, value:true),
    ChipChoiceModel(name:'calories', category: mealCategory, value:false),
    ChipChoiceModel(name:'hydration', category: drinkCategory, value:true),
    ChipChoiceModel(name:'strength', category: workoutCategory, value:false),
    ChipChoiceModel(name:'favorites', category: isFavoriteCategory, value:true),
  ];

  List<CalculationModel> calculationList = [
    CalculationModel(title:'BMI', category: supplementCategory, isFavorite: true),
    CalculationModel(title:'BMR', category: supplementCategory, isFavorite: true),
    CalculationModel(title:'TER', category: mealCategory, isFavorite: false),
    CalculationModel(title:'H2O', category: drinkCategory, isFavorite: true),
    CalculationModel(title:'PROTEIN', category: supplementCategory, isFavorite: true),
    CalculationModel(title:'CARBO', category: supplementCategory, isFavorite: false),
    CalculationModel(title:'LOW FAT', category: drinkCategory, isFavorite: true),
    CalculationModel(title:'MAX BENCH', category: supplementCategory, isFavorite: true),
    CalculationModel(title:'WHR', category: supplementCategory, isFavorite: false),
  ];
//   [
//   CalculationModel( category: supplementCategory)
//   CalculationModel( category: mealCategoryCategory)
//   CalculationModel( category: drinkCategory)
//   CalculationModel( category: supplementCategory)
//   CalculationModel( category: mealCategoryCategory)
// ];
  // todo: utwórz funkcje sortCalculationList(), która aktualizuje listę i wyświetla tylko te elementy
  //  z calculationList, których kategoria zgadza się z kategorią choiceChipList ale tylko
  //  jeśli value == true (w choiceChipList). W innym przypadku (value == false) nie wyświetla elementów z tej kategorii
  void sortCalculationList() {
    List<CalculationModel> filteredList = [];
    Map<String, List<CalculationModel>> categorizedItems = {};

    // Grupowanie elementów z calculationList według kategorii
    calculationList.forEach((calculation) {
      if (!categorizedItems.containsKey(calculation.category)) {
        categorizedItems[calculation.category!] = [];
      }
      categorizedItems[calculation.category!]!.add(calculation);
    });
    for (var chip in choiceChipList) {
      if (chip.value == true) {
        for (var calculation in calculationList) {
          if (calculation.category == chip.category ) {
            if (!filteredList.contains(calculation)) {
              categorizedItems.forEach((key, value) {
                if (value.isNotEmpty) {
                  // Sprawdź, czy wartość następnej kategorii jest różna od aktualnej
                  if (filteredList.isNotEmpty && filteredList.last.category != key) {
                    filteredList.add(value.removeAt(0));
                  } else {
                    // Jeśli kategorie są takie same, po prostu dodaj do listy
                    filteredList.add(calculation);
                  }
                }
              });
              //filteredList.add(calculation);
            }
          } else if (calculation.isFavorite == true && chip.category == isFavoriteCategory) {
            if (!filteredList.contains(calculation)) {
              categorizedItems.forEach((key, value) {
                if (value.isNotEmpty) {
                  // Sprawdź, czy wartość następnej kategorii jest różna od aktualnej
                  if (filteredList.isNotEmpty && filteredList.last.category != key) {
                    filteredList.add(value.removeAt(0));
                  } else {
                    // Jeśli kategorie są takie same, po prostu dodaj do listy
                    filteredList.add(calculation);
                  }
                }
              });
              // filteredList.add(calculation);
            }
          }
        }
      }
    }

    // Aktualizuj calculationList, aby zawierał tylko przefiltrowane elementy
    calculationList.clear();
    calculationList.addAll(filteredList);

    // Notify listeners about the change
    notifyListeners();
  }

}
// Map<String, List<CalculationModel>> categorizedItems = {};
//
// // Grupowanie elementów z list według kategorii
// list.forEach((calculation) {
// if (!categorizedItems.containsKey(calculation.category)) {
// categorizedItems[calculation.category!] = [];
// }
// categorizedItems[calculation.category!]!.add(calculation);
// });
// // Sprawdzamy, ile chipów ma wartość true
// int trueChipCount = choiceChipList.where((chip) => chip.value == true).length;
//
// // Jeśli nie ma chipów z wartością true
// if (trueChipCount == 0) {
// // Zwracamy pustą listę
// list.clear();
// notifyListeners();
// // return;
// }// Jeśli jest tylko jeden chip z wartością true
// else if (trueChipCount == 1) {
// // Znajdujemy ten jeden chip
// var trueChip = choiceChipList.firstWhere((chip) => chip.value == true);
// // Zwracamy elementy z kategorii odpowiadającej temu chipowi
// list.clear();
// list.addAll(categorizedItems[trueChip.category!] ?? []);
// notifyListeners();
// //return;
// }
// // Jeśli są co najmniej dwa chipy z wartością true
// else {
// // Sortujemy elementy na przemian według kategorii
// categorizedItems.forEach((key, value) {
// filteredList.addAll(value);
// });
// list.clear();
// list.addAll(filteredList);
// notifyListeners();
// // return;
// }