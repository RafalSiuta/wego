import 'dart:collection';
import 'package:flutter/material.dart';
import '../../model/actvity_model/activity_model.dart';

class UserActivityLevel {

  List<ActivityModel> _activityLevelList = [
    ActivityModel(
      icon: Icons.self_improvement,
      description: "activity_list_very_low",// , daily routine, light office work, cleaning house
    ),
    ActivityModel(
      icon: Icons.nordic_walking,
      description: "activity_list_low",//, light laborer work, random jogging",
    ),
    ActivityModel(
      icon: Icons.rowing,
      description:  "activity_list_medium",//, harder laborer work random sports, swimming, regular jogging,",
    ),
    ActivityModel(
      icon: Icons.sports_handball,
      description: "activity_list_high",//, regular sport, gym, play football, fitness",
    ),
    ActivityModel(
      icon: Icons.sports_martial_arts,
      description: "activity_list_very_high",//, heavy weight lifting, martial arts, bodybuilding",
    ),
  ];

  UnmodifiableListView<ActivityModel> get activityLevel {
    return UnmodifiableListView(_activityLevelList);
  }

  int get activityLevelListCounter => _activityLevelList.length;

  set activityLevel(List<ActivityModel> value) {
    _activityLevelList = value;
  }
}