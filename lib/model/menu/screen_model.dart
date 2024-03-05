import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'nav_model.dart';

class ScreenModel {
  ScreenModel({required this.page, required this.navItem});

  final Widget? page;
  // final BottomNavigationBarItem? navItem;
  final NavModel? navItem;
}
