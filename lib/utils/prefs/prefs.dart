import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/nutrition_model/nutrition_settings_model.dart';
import '../../model/slider_model/slider_model.dart';


class Prefs extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> storeInt(String key, int value) async {
    final prefs = await _prefs;
    await prefs.setInt(key, value);
    notifyListeners();
  }

  Future<int> restoreInt(String key, int input) async {
    final prefs = await _prefs;
    final inputValue = prefs.getInt(key) ?? 0;
    input = inputValue;
    notifyListeners();
    return input;
  }

  Future<void> storeString(String key, String value) async {
    final prefs = await _prefs;
    await prefs.setString(key, value);
    notifyListeners();
  }

  Future<String> restoreString(String key, String input) async {
    final prefs = await _prefs;
    final inputValue = prefs.getString(key) ?? "";
    input = inputValue;
    notifyListeners();
    return input;
  }

  Future<void> storeDouble(String key, double value) async {
    final prefs = await _prefs;
    await prefs.setDouble(key, value);
    notifyListeners();
  }

  Future<double> restoreDouble(String key, double input) async {
    final prefs = await _prefs;
    final inputValue = prefs.getDouble(key) ?? 0;
    input = inputValue;
    notifyListeners();
    return input;
  }

  Future<void> storeBool(String key, bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(key, value);
    notifyListeners();
  }

  Future<bool> restoreBool(String key, bool input) async {
    final prefs = await _prefs;
    final inputValue = prefs.getBool(key) ?? false;
    input = inputValue;
    notifyListeners();
    return input;
  }

  Future storeList(String key, List list) async {
    List<String> mySliders = list.map((f) => json.encode(f.toMap())).toList();

    final prefs = await _prefs;

    await prefs.setStringList(key, mySliders);
    notifyListeners();
  }

  Future<List> restoreList(String key, List list) async {
    final prefs = await _prefs;
    final result = prefs.getStringList(key); // ?? [];

    try {
      if (result != null) {
        list = result.map((i) {
          return SliderModel.fromJson(jsonDecode(i));
        }).toList();
      }
    } catch (e) {}

    notifyListeners();
    return list;
  }

  Future<List> restoreSettingsList(String key, List list) async {
    final prefs = await _prefs;

    final result = prefs.getStringList(key);

    try {
      if (result != null) {
        list = result.map((i) {
          return NutritionSettingsModel.fromJson(jsonDecode(i));
        }).toList();
      }
    } catch (e) {}

    notifyListeners();
    return list;
  }

  // Future<List<TrashModel>> restoreTrashList(
  //     String key, List<TrashModel> list) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final result = prefs.getStringList(key);
  //
  //   try {
  //     if (result != null) {
  //       list = result.map((i) {
  //         return TrashModel.fromMap(jsonDecode(i));
  //       }).toList();
  //     }
  //   } catch (e) {}
  //
  //   notifyListeners();
  //   return list;
  // }
}
