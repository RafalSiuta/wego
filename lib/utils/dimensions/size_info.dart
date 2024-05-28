import 'package:wego/utils/dimensions/screen_type.dart';
import 'package:flutter/widgets.dart';

class SizeInfo {
  final ScreenType? screenType;
  final Size? screenSize;

  SizeInfo({this.screenSize, this.screenType}) {
    initDimensions();
  }

  static int gridColumnCount = 2;

  ///padding / margins:
  static double edgePadding = 12.0;
  static double menuTopMargin = 8.0;

  ///corner radius
  static double cornerRadius = 15.0;

  ///general - repeat in other widgets:
  static double headerTitleSize = 28;
  static double headerSubtitleSize = 15;
  static double verticalHeaderPadding = 5.0;

  static double helpTextSize = 8.0;

  static double topMargin = 24;

  static double iconSize = 18;

  ///social bar:
  static double socialIcons = 18;

  ///nav rail dimens:
  static double leadingAndTrailingIconSize = 18;
  static double navSideTitleSize = 18;

  //project dimens:
  static double projectCardHeight = 130;

  ///task dimens:
  static double taskCardHeight = 76;
  static double taskCardTitle = 12;
  static double taskCardDescription = 10;
  static double taskCreatorTitle = 18;
  static double taskCreatorDescription = 12;
  static double timeCardColor = 8.0;
  static double leftEdgePadding = 12;

  ///note dimens:
  static double noteCardImageSize = 50;
  static double noteCardTitle = 10;
  static double noteCardContent = 7.0;
  static double noteLeftPadding = 16;
  static double scaleCard = 0.8;
  static double verticalTextPadding = 12.0;
  static double cameraIconButtonSize = 35;

  ///search bar:
  static double searchBarHeight = 50;
  static double searchIconSize = 18;

  ///calendar dimens:
  static double calendarDaySize = 12;
  static double smallIndicatorIconSize = 10;
  static double calendarMarkerSize = 12.2;//15;
  static double calendarMarkerFontSize = 6.0;//10.0;
  static double calendarCellMargin = 8.0;
  static double rowHeight = 40;

  ///settings dimens:
  static double settingsCardTitleFontSize = 12;
  static double settingsCardDescriptionFontSize = 10;
  static double settingsCardHeight = 60;

  ///carousel height:
  static double carouselHeight = 4;

  void initDimensions() {
    print('DIMENSIONS INITIALIZED');
    if (screenType == ScreenType.smallMobile) {}
    if (screenType == ScreenType.tablet) {
      tabletDimens();
    }
    if (screenType == ScreenType.desktop) {
      tabletDimens();
    }
  }

  void tabletDimens() {
    edgePadding = 12.0;
    taskCardHeight = 100;
    gridColumnCount = 3;
    calendarDaySize = 23;
    smallIndicatorIconSize = 15;
    menuTopMargin = 32;

    helpTextSize = 13;

    ///social bar:
    socialIcons = 23;

    ///nav rail:
    leadingAndTrailingIconSize = 40;
    navSideTitleSize = 32;

    ///headers:
    headerTitleSize = 42;
    headerSubtitleSize = 32;
    verticalHeaderPadding = 16;

    ///calendar
    rowHeight = 72;
    calendarMarkerSize = 23;
    calendarMarkerFontSize = 15;
    calendarCellMargin = 12;
    iconSize = 23;

    ///task card:
    taskCardTitle = 23.0;
    taskCardDescription = 18;
    taskCreatorTitle = 32;
    taskCreatorDescription = 23;

    ///note card:
    noteCardTitle = 18;
    noteCardContent = 15;
    noteLeftPadding = 27;
    scaleCard = 0.9;
    verticalTextPadding = 15;
    cameraIconButtonSize = 52;

    ///search bar
    searchBarHeight = 72;
    searchIconSize = 32;

    ///settings card:
    settingsCardHeight = 90;
    settingsCardTitleFontSize = 23;
    settingsCardDescriptionFontSize = 18;
    iconSize = 30;

    ///carousel:
    carouselHeight = 3;
  }
}
