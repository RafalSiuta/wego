import 'package:flutter/widgets.dart';
import './nav_model.dart';

class SubScreenModel {
  SubScreenModel({required this.page, required this.title});

  final Widget? page;
  final NavModel? title;
}