import 'package:wego/providers/profile_provider/user_activity.dart';
import 'package:wego/providers/profile_provider/user_activity_level.dart';
import 'package:wego/providers/profile_provider/user_nutrition.dart';
import 'package:flutter/material.dart';
import 'package:wego/providers/profile_provider/user_body_data.dart';
import '../../data/dummy_chart_data.dart';
import '../../model/chart_model/chart_model.dart';
import '../../model/user_data_model/user_data_model.dart';
import '../../utils/prefs/prefs.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:wego/utils/constans/prefs_keys.dart';


class ProfileProvider extends ChangeNotifier {

  ProfileProvider(){
  initProfileProviderData();
  }

  initProfileProviderData() async {
    userDataList = usrData.userBodyData;
    userPowerActivityList = activityPowerData.activityPowerData;
    userActivityLevelList = userActivityLevel.activityLevel;
    userNutritionDataList = userNutritionData.customNutritionList;
    userNutritionDefaultList = userNutritionData.defaultNutritionList;
    getUserDataValues();
    getUserActivityValues();
    getUserNutritionValues();
    getUserData();

    chipBodyList = userDataList.getRange(1, userDataList.length).toList();
    switchChartData(0);
  }

  final Prefs _prefs = Prefs();

  //gender setup
  bool isGenderSelected = true;

  void onGenderSelect(bool sel){
    isGenderSelected = sel;
    _prefs.storeBool(userGenderKey, isGenderSelected);
    getUserDataValues();
    notifyListeners();
  }

  //UserDataModel userData = UserDataModel();
  //user data sliders setup:
  UserBodyData usrData = UserBodyData();

  List userDataList = [];

  //stats chips btn selectors:
  int selectedChip = 0;
  List chipBodyList = [];

  void userChipChoice(int index, bool val) {

    for (int i = 0; i < chipBodyList.length; i++) {
      print('SELECTED CHIP BODY: ${i}: ${index}');
      val = (i == index);

      //userDataList[i].isActiveChips = (i == index) && val;
    }
    selectedChip = index;
    switchChartData(index);
    notifyListeners();
  }
  List<ChartModel> profileSavesList = [];
  void switchChartData(int index){

    switch(index){
      case 0:
        profileSavesList = DUMMY_WEIGHT_CHART_DATA;
        break;
      case 1:
        profileSavesList = DUMMY_WEIGHT_CHART_DATA;
        break;
      case 2:
        profileSavesList = DUMMY_WAIST_CHART_DATA;
        break;
      case 3:
        profileSavesList = DUMMY_HIPS_CHART_DATA;
        break;
      case 4:
        profileSavesList = DUMMY_NECK_CHART_DATA;
        break;
      default:
        profileSavesList = DUMMY_WEIGHT_CHART_DATA;
    }
  }


  void setUserData( int index, double maxValue,{double? newValue,String? operator}) {
    var data = userDataList[index];
    if (operator == '+') {
      if(data.sliderValue <  maxValue){
        data.sliderValue++;
      }else{
        //do nothink
      }
    } else if (operator == '-') {

      if (data.sliderValue != 0) {
        data.sliderValue--;
      }
    } else {

      data.sliderValue = newValue!.roundToDouble();
    }
    _prefs.storeList(userBodyDataKey, userDataList);

    getUserDataValues();
    notifyListeners();
  }

  getUserDataValues() async {

    isGenderSelected = await _prefs.restoreBool(userGenderKey, isGenderSelected);
    userDataList =
        await _prefs.restoreList(userBodyDataKey, userDataList) ?? userDataList;
    getUserData();
    notifyListeners();
  }

   //user activity setup:
  UserActivityLevel userActivityLevel = UserActivityLevel();
  List userActivityLevelList = [];

    UserActivityPowerData activityPowerData = UserActivityPowerData();
    List userPowerActivityList = [];

    int activityLevel = 0;
    CarouselController carouselController = CarouselController();


  goToPrevious() {
    carouselController.previousPage(
        duration:const  Duration(milliseconds: 400), curve: Curves.ease);
    //carousel.carouselActivity = calcResult.activity;

    _prefs.storeInt(userActivityLevelKey, activityLevel);
    getUserData();
    notifyListeners();
  }

  goToNext() {
    carouselController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.decelerate);
    //carousel.carouselActivity = calcResult.activity;
    _prefs.storeInt(userActivityLevelKey, activityLevel);
    getUserData();
    notifyListeners();
  }
  //
  onActivityChange(int index) {
    activityLevel = index;
    // calcResult.activity = index;
    // carousel.carouselActivity = index;
    // carousel.carouselActivity = calcResult.activity;
   // print("User activity level value: ${activityLevel}");
    _prefs.storeInt(userActivityLevelKey, activityLevel);
    getUserData();
    notifyListeners();
  }

  setPowerActivityData(int index, double maxValue,{double? newValue, String? operator, }) {
    var data = userPowerActivityList[index];
    if (operator == '+') {
      if(data.sliderValue < maxValue){
        data.sliderValue++;
      }else{

      }

    } else if (operator == '-') {
      if (data.sliderValue != 0) {
        data.sliderValue--;
      }
    } else {
      data.sliderValue = newValue!.roundToDouble();
    }
    _prefs.storeList(userActivityListKey, userPowerActivityList);
    getUserActivityValues();
    notifyListeners();
  }

  // getActivityPowerData() async {
  //   activityLevel =
  //   await _prefs.restoreInt(userActivityLevelKey, activityLevel);
  //   userPowerActivityList =
  //       await _prefs.restoreList(userActivityListKey, userPowerActivityList) ??
  //           userPowerActivityList;
  //
  //   // this.calcResult.bench = activity.activityList[0].sliderValue;
  //   // this.calcResult.squat = activity.activityList[1].sliderValue;
  //   // this.calcResult.deadLift = activity.activityList[2].sliderValue;
  //   // updateCalculationList();
  //   notifyListeners();
  // }

  getUserActivityValues() async {
    activityLevel =
        await _prefs.restoreInt(userActivityLevelKey, activityLevel);
    userPowerActivityList =
        await _prefs.restoreList(userActivityListKey, userPowerActivityList) ??
        userPowerActivityList;
    getUserData();
    notifyListeners();
  }

  //user nutrition data:
  UserNutrition userNutritionData = UserNutrition();
  List userNutritionDataList = [];
  List userNutritionDefaultList = [];

  bool isCustomNutrition = false;
  int defaultNutritionChoice = 0;

  setNutritionData(int index,double maxValue, {double? newValue, String? operator, }) {
    var data = userNutritionDataList[index];
    if (operator == '+') {
      if(data.sliderValue < maxValue){
        data.sliderValue++;
      }else{

      }

    } else if (operator == '-') {
      if (data.sliderValue != 0) {
        data.sliderValue--;
      }
    } else {
      data.sliderValue = newValue!.roundToDouble();
    }
    _prefs.storeList(userNutritionListKey , userNutritionDataList);
    getUserNutritionValues();
    notifyListeners();
  }

  onNutritionModelSwitch(bool newValue) {
    isCustomNutrition = newValue;
    _prefs.storeBool(nutritionChoiceSwitchKey, isCustomNutrition);
    getUserNutritionValues();
    notifyListeners();
  }

  onDefaultNutritionChoice(int? newVal) {
    defaultNutritionChoice = newVal!;
    _prefs.storeInt(defaultNutritionChoiceKey, defaultNutritionChoice);

    getUserNutritionValues();
    // updateCalculationList();
    notifyListeners();
  }

  getUserNutritionValues() async {
    isCustomNutrition = await _prefs.restoreBool(
        nutritionChoiceSwitchKey, isCustomNutrition);


    if(isCustomNutrition == false){
      defaultNutritionChoice = await _prefs.restoreInt(defaultNutritionChoiceKey, defaultNutritionChoice);

    }else{
      userNutritionDataList =  await _prefs.restoreList(
          userNutritionListKey, userNutritionDataList);

    }
    getUserData();
  notifyListeners();
  }
  UserDataModel userData = UserDataModel();

  UserDataModel getUserData() {

    List? data = [...userDataList, ...userPowerActivityList];

    userData.gender = isGenderSelected;
    userData.activity = activityLevel;

   // print('ITEMS NUMBER ${data.length}');
    for(int i = 0; i < data.length; i++){
     // print('This is new list from all sliders - ${data[i].name}');
      switch(data[i].name){
        case 'age':
          userData.age = data[i].sliderValue.toDouble();
          break;
        case 'weight':
          userData.weight = data[i].sliderValue.toDouble();
          break;
        case 'height':
          userData.height = data[i].sliderValue.toDouble();
          break;
        case 'waist':
          userData.waist = data[i].sliderValue.toDouble();
          break;
        case 'hips':
          userData.hips = data[i].sliderValue.toDouble();
          break;
        case 'neck':
          userData.neck = data[i].sliderValue.toDouble();
          break;
        case 'bench_press':
          userData.benchPressPower = data[i].sliderValue.toDouble();
          break;
        case 'squat':
          userData.squatPower = data[i].sliderValue.toDouble();
          break;
        case 'dead_lift':
          userData.deadLiftPower = data[i].sliderValue.toDouble();
          break;
      }
    }

    if(isCustomNutrition == true){

      for(int i = 0; i < userNutritionDataList.length ; i++){
        //print('This is new list nutri data custom nutri ${isCustomNutrition} - ${userNutritionDataList[i].name}');
        switch(userNutritionDataList[i].name){
          case 'protein':
            userData.proteinPercent = userNutritionDataList[i].sliderValue.toDouble();
            break;
          case 'carbo':
            userData.carbPercent = userNutritionDataList[i].sliderValue.toDouble();
            break;
          case 'fat':
            userData.fatPercent = userNutritionDataList[i].sliderValue.toDouble();
            break;
        }
      }
    }else{

      for(int i = 0; i < userNutritionDefaultList.length ; i++){
       // print('This is new list nutri data custom nutri i val: $i :\n${isCustomNutrition} - ${userNutritionDefaultList[i].name}');

        // print('SETUP VALUES nutrition choice: $defaultNutritionChoice \nprot ${userData.proteinPercent} \ncarb ${userData.carbPercent} \nfat ${userData.fatPercent}');

        userData.proteinPercent = userNutritionDefaultList[defaultNutritionChoice].protein.toDouble();
        userData.carbPercent = userNutritionDefaultList[defaultNutritionChoice].carbohydrate.toDouble();
        userData.fatPercent = userNutritionDefaultList[defaultNutritionChoice].fat.toDouble();
        // switch(defaultNutritionChoice){
        //   case 0:
        //
        //
        //    // print('WEIGHT LOSS: \nprot ${userData.proteinPercent} \ncarb ${userData.carbPercent} \nfat ${userData.fatPercent}');
        //     break;
        //   case 1:
        //     userData.proteinPercent = userNutritionDefaultList[1].protein.toDouble();
        //     userData.carbPercent = userNutritionDefaultList[1].carbohydrate.toDouble();
        //     userData.fatPercent = userNutritionDefaultList[1].fat.toDouble();
        //    // print('WEIGHT MAINTAIN: \nprot ${userData.proteinPercent} \ncarb ${userData.carbPercent} \nfat ${userData.fatPercent}');
        //     break;
        //   case 2:
        //     userData.proteinPercent = userNutritionDefaultList[2].protein.toDouble();
        //     userData.carbPercent = userNutritionDefaultList[2].carbohydrate.toDouble();
        //     userData.fatPercent = userNutritionDefaultList[2].fat.toDouble();
        //     //print('WEIGHT GAIN: \nprot ${userData.proteinPercent} \ncarb ${userData.carbPercent} \nfat ${userData.fatPercent}');
        //     break;
        // }
        notifyListeners();
      }
    }

    notifyListeners();
    return userData;
  }

}