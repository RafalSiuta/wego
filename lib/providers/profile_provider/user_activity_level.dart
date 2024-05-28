import 'dart:collection';
import 'package:flutter/material.dart';
import '../../model/actvity_model/activity_model.dart';
import '../../utils/extensions/wego_sys_icons.dart';

class UserActivityLevel {

  List<ActivityModel> _activityLevelList = [
    ActivityModel(
      icon: SysIcons.very_low_activity,
      description: "activity_list_very_low",// , daily routine, light office work, cleaning house
    ),
    ActivityModel(
      icon: SysIcons.low_activity,
      description: "activity_list_low",//, light laborer work, random jogging",
    ),
    ActivityModel(
      icon: SysIcons.medium_activity,
      description:  "activity_list_medium",//, harder laborer work random sports, swimming, regular jogging,",
    ),
    ActivityModel(
      icon: SysIcons.high_activity,
      description: "activity_list_high",//, regular sport, gym, play football, fitness",
    ),
    ActivityModel(
      icon: SysIcons.very_high_activity,
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