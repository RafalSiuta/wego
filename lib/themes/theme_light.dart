import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const mainBcgColor = Color(0xFFf7f6fe);//EEEEEE  //f7f6fe
const titleBoxBcgColor = Colors.white;
// const theme_4firstGradientColor = Color(0xFF00C3FF);
// const theme_4middleGradientColor = Color(0xFF1B6BFF);
// const theme_4lastGradientColor = Color(0xFF2525FF);
const theme_4firstGradientColor = Color(0xFF876eff);//4a32bf
const theme_4middleGradientColor = Color(0xFFB1CEB7);
const theme_4lastGradientColor = Color(0xFF4a32bf);
const theme_4noteCardColor = Color(0xFFf5f5f5); //Color(0xFFdec9ab);f5f5f5
const theme_4descriptionColor = Color(0xFF636363);
const dividerColor = Color(0xFF636363);
const unselectedColor = Color(0xFF9e9e9e); //595959
//const theme_4calendarWeekendColor = Color(0xFFab977b);
const indicatorColor = Color(0xFF6F57E5);//Color(0xFFffca28); Color(0xFFF3EBA0); Color(0xFF94FFAF)// FEA735 f5f5f5 //94FFAF
const theme_4shadowColor = Color(0xFFC0C0C0);
const baseTextColor = Color(0xFF091C2B);
const menuSelectionBackground = Color(0xFF6F57E5);//7a5eff
const lightAccentShade = Color(0xFF876eff);
const cardLightBackground = Color(0xFFD5CEFD);//D5CEFD //D5CEFD //9585F9 //998BF6
const cardDarkBackground = Color(0xFF9585F9);


final themeLight = ThemeData(

    brightness: Brightness.light,
    useMaterial3: true,
    splashFactory: NoSplash.splashFactory,
    scaffoldBackgroundColor: mainBcgColor,
    // backgroundColor: theme_2TitleBoxBcgColor,

    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: theme_4firstGradientColor,
      onPrimary: theme_4lastGradientColor,
      secondary: Colors.white,
      onSecondary: menuSelectionBackground,
      error: Color(0xFFF32424),
      onError: Color(0xFFF32424),
      background: titleBoxBcgColor,
      onBackground: titleBoxBcgColor,
      surface: cardLightBackground,
      onSurface: cardDarkBackground,
    ),
    canvasColor: titleBoxBcgColor,
    focusColor: theme_4middleGradientColor,

    unselectedWidgetColor: unselectedColor,
    primaryColor: theme_4firstGradientColor,
    primaryColorLight: theme_4middleGradientColor,
    primaryColorDark: theme_4lastGradientColor,
    cardColor: theme_4middleGradientColor,
    indicatorColor: indicatorColor,
    highlightColor: Colors.transparent,
    shadowColor: mainBcgColor,
    dialogBackgroundColor: theme_4lastGradientColor,
    primarySwatch: Colors.amber,
    splashColor: Colors.transparent,
    textTheme: TextTheme(
      /// main big title //headline 1
      headlineLarge: GoogleFonts.exo2(
          textStyle: const TextStyle(
            color: baseTextColor ,
            fontSize: 32,
            fontWeight: FontWeight.bold
          )),
      /// list title //headline 3 // calendar header/ header secondary date
      headlineMedium: GoogleFonts.exo2(
        textStyle: const TextStyle(
            fontSize: 18,
            color: baseTextColor ,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none,
            overflow: TextOverflow.ellipsis),
      ),
      //headlineSmall: null,
      /// date header style
      displayLarge: GoogleFonts.exo2(
          textStyle: const TextStyle(
              fontSize: 18,
              color: theme_4lastGradientColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 2)),
      //small selected text
      displayMedium: GoogleFonts.exo2(
          textStyle: const TextStyle(
              fontSize: 10,
              color: indicatorColor,
              fontWeight: FontWeight.w500,
              )),
      //small unselected text
      displaySmall: GoogleFonts.exo2(
          textStyle: const TextStyle(
              fontSize: 10,
              color: unselectedColor,
              fontWeight: FontWeight.w500,)),
      ///calendar weekend text style
      bodyLarge: GoogleFonts.exo2(
          textStyle: const TextStyle(
            fontSize: 18,
            color: indicatorColor,
          )),
      //task/note/project description text style:
      bodyMedium:  GoogleFonts.exo2(
          textStyle: const TextStyle(
              fontSize: 10,
              color: theme_4lastGradientColor,
              fontWeight: FontWeight.w300,
              overflow: TextOverflow.ellipsis)),
      ///calendar marker style
      bodySmall: GoogleFonts.exo2(
          textStyle: const TextStyle(
              fontSize: 10,
              color: theme_4noteCardColor,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis)),
      titleSmall: GoogleFonts.exo2(
          textStyle: const TextStyle(
              fontSize: 10,
              color: titleBoxBcgColor,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis)),
      titleLarge: GoogleFonts.exo2(
        textStyle: const TextStyle(
            fontSize: 18,
            color: baseTextColor ,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
            overflow: TextOverflow.ellipsis),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double?>(0.0),
        surfaceTintColor: MaterialStateProperty.all<Color?>(Colors.transparent),
        foregroundColor: MaterialStateProperty.all<Color?>(Colors.transparent),
        backgroundColor: MaterialStateProperty.all<Color?>(Colors.transparent),
        alignment: Alignment.center,
        overlayColor: MaterialStateProperty.all<Color?>(Colors.transparent),
        textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered))
              return GoogleFonts.exo2(
                  textStyle: const TextStyle(
                    fontSize: 10,
                    color: unselectedColor,
                    fontWeight: FontWeight.w400,
                  ));
            if (states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed))
              return GoogleFonts.exo2(
                  textStyle: const TextStyle(
                    fontSize: 10,
                    color: indicatorColor,
                    fontWeight: FontWeight.w500,
                  ));
            return GoogleFonts.exo2(
                textStyle: const TextStyle(
                  fontSize: 10,
                  color: indicatorColor,
                  fontWeight: FontWeight.w500,
                )); // Defer to the widget's default.
          },
        ),
        iconColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered))
              return unselectedColor;
            if (states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed))
              return indicatorColor;
            return unselectedColor; // Defer to the widget's default.
          },
        ),
      )
    ),
    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          
          alignment: Alignment.center,
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered))
                  return unselectedColor;
                if (states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed))
                  return titleBoxBcgColor.withOpacity(0.1);
                return unselectedColor; // Defer to the widget's default.
              },
            ),
            iconColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered))
                return unselectedColor;
              if (states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.pressed))
                return indicatorColor;
              return unselectedColor; // Defer to the widget's default.
            },
          ),
        )
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(mainBcgColor.withOpacity(0.1))
        )
    ),

    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: Colors.transparent,
    ),
    dividerTheme: const DividerThemeData(
      color: dividerColor,
      thickness: 0.5,

    ),
    cardTheme: CardTheme(
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          //side: BorderSide(color: Theme.of(context).disabledColor, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      color: titleBoxBcgColor,//theme_4TitleBoxBcgColor
    ),
    sliderTheme: SliderThemeData(
      trackShape: RectangularSliderTrackShape(),
      trackHeight: 2,
      activeTrackColor:indicatorColor,
      inactiveTrackColor: unselectedColor,
      thumbColor: titleBoxBcgColor,
      overlayColor: titleBoxBcgColor.withOpacity(0.3),
      thumbShape:
      const RoundSliderThumbShape(enabledThumbRadius: 10),
      overlayShape: RoundSliderOverlayShape(
          overlayRadius: 20),
    ),
    navigationRailTheme: NavigationRailThemeData(
      labelType: NavigationRailLabelType.all,
      useIndicator: true,

      indicatorColor: Colors.transparent,
      groupAlignment: -.5,
      selectedIconTheme: const IconThemeData(
        color: indicatorColor,

      ),
      unselectedIconTheme: const IconThemeData(color: unselectedColor,),
      selectedLabelTextStyle: GoogleFonts.exo2(
        textStyle: const TextStyle(
            color: baseTextColor , fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
      unselectedLabelTextStyle: GoogleFonts.exo2(
          textStyle: const TextStyle(
              color: unselectedColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w500
          )),
    ),
   // actionIconTheme: const ActionIconThemeData(),//const IconThemeData(color: theme_4noteCardColor, size: 18),
    iconTheme: const IconThemeData(color: indicatorColor, size: 15),
    switchTheme: SwitchThemeData(

        thumbColor: MaterialStateProperty.resolveWith(
              (states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.white;
            } else {
              return Colors.white;
            }
          },
        ),
        trackColor: MaterialStateProperty.resolveWith(
              (states) {
            if (states.contains(MaterialState.selected)) {
              return indicatorColor;
            } else if (states.contains(MaterialState.disabled)){
              return unselectedColor;
            } else{
              return unselectedColor;
            }
          },
        ),),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith(
            (states) {
          if (states.contains(MaterialState.selected)) {
            return indicatorColor;
          } else if (states.contains(MaterialState.disabled)){
            return unselectedColor;
          } else{
            return unselectedColor;
          }
        },
      )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: titleBoxBcgColor,

      selectedIconTheme: const IconThemeData(
        size: 18.0,
        color: indicatorColor
      ),
      unselectedIconTheme: const IconThemeData(
            size: 18.0,
            color: unselectedColor
      ),
      selectedLabelStyle:  GoogleFonts.exo2(
          textStyle: const TextStyle(
              color: indicatorColor,
              fontSize: 10.0,
              fontWeight: FontWeight.w500
          )),
      unselectedLabelStyle:GoogleFonts.exo2(
          textStyle: const TextStyle(
              color: unselectedColor,
              fontSize: 10.0,
              fontWeight: FontWeight.w500
          )),
      selectedItemColor: indicatorColor,
      unselectedItemColor: unselectedColor
    ),
    floatingActionButtonTheme:
    const FloatingActionButtonThemeData(
        backgroundColor: indicatorColor
    ),
    dialogTheme: DialogTheme(
        elevation: 5.0,
        titleTextStyle: GoogleFonts.exo2(
          textStyle: const TextStyle(
              color: theme_4noteCardColor,
              fontSize: 18,
              fontWeight: FontWeight.w400),
        ),
        contentTextStyle: GoogleFonts.exo2(
          textStyle: const TextStyle(
              color: theme_4noteCardColor,
              fontSize: 12,
              fontWeight: FontWeight.w400),
        ),
        backgroundColor: mainBcgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      focusedBorder:const UnderlineInputBorder(
          borderSide: BorderSide(
            width: .5,
            color: dividerColor,
          )),
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      isDense: true,
      filled: false,
      hintStyle: GoogleFonts.exo2(
          textStyle: const TextStyle(
            fontSize: 15,
            color: unselectedColor,
            fontWeight: FontWeight.w500,)),
      contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
      suffixStyle: const TextStyle(
        color: unselectedColor,
      ),
      labelStyle: const TextStyle(
        color: theme_4noteCardColor,
      ),
      helperMaxLines: 1,
      helperStyle: GoogleFonts.exo2(
        textStyle: const TextStyle(
          color: unselectedColor,
          fontSize: 7.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      alignLabelWithHint: true,
      prefixStyle: const TextStyle(
        color: theme_4noteCardColor,
      ),
    ),
    progressIndicatorTheme:const ProgressIndicatorThemeData(
      refreshBackgroundColor: unselectedColor,
      linearTrackColor: indicatorColor,

      // linearTrackColor: theme_4indicatorColor


    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent, // theme_4TitleBoxBcgColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
            left: (Radius.circular(15)), right: (Radius.circular(15))),
      ),
    ),
    tabBarTheme: TabBarTheme(
      dividerColor: dividerColor.withOpacity(0.5),

      overlayColor: MaterialStateProperty.all(Colors.transparent),
      indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.0, color: indicatorColor),
          insets: EdgeInsets.symmetric(horizontal: 12.0),),
      labelColor: baseTextColor ,
      unselectedLabelColor: unselectedColor,
      unselectedLabelStyle: GoogleFonts.exo2(
        textStyle: const TextStyle(
            fontSize: 15,
            color: unselectedColor,
            fontWeight: FontWeight.w300,
            decoration: TextDecoration.none),
      ),
      labelStyle: GoogleFonts.exo2(
        textStyle: const TextStyle(
            fontSize: 15,
            color: baseTextColor ,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
            overflow: TextOverflow.ellipsis),
      ),
    ),
    chipTheme: ChipThemeData(
        showCheckmark: false,
      shadowColor: Colors.transparent,
      disabledColor: unselectedColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: const BorderSide(color: dividerColor),
      ),
      side: const BorderSide(style: BorderStyle.none)
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Colors.white),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered))
            return indicatorColor;
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.pressed))
            return indicatorColor;
          return unselectedColor; // Defer to the widget's default.
        },
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
      fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered))
            return indicatorColor;
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.pressed))
            return indicatorColor;
          return Colors.transparent;
        },
      ),

    ),
  expansionTileTheme: ExpansionTileThemeData(
    textColor: baseTextColor,
    backgroundColor: titleBoxBcgColor,
    collapsedBackgroundColor:titleBoxBcgColor,
    collapsedShape: RoundedRectangleBorder(
      side: BorderSide.none,
    ),
    shape: RoundedRectangleBorder(
      side: BorderSide.none,
    ),

    expandedAlignment: Alignment.topLeft,
    iconColor: indicatorColor,
    collapsedIconColor: unselectedColor

  )

);


