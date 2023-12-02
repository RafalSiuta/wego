import 'package:flutter/material.dart';
import 'package:wego/screens/stats_screen/stats_subscreens/calculation_screen.dart';
import 'package:wego/screens/stats_screen/stats_subscreens/calendar_screen.dart';
import 'package:wego/screens/stats_screen/stats_subscreens/statistics_screen.dart';

import '../../widgets/navigators/tab_nav.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Expanded(
          child: TabNav(
              tabTitles: [
                "Calendar", "Calculations", "Statistics"
              ],
              list:[
                CalendarScreen(),
                CalculationScreen(),
                StatisticsScreen()

              ]
          ),
        )
      ],
    );
  }
}
