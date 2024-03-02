import 'package:flutter/material.dart';
import 'package:wego/screens/stats_screen/stats_subscreens/calculation_screen.dart';
import 'package:wego/screens/stats_screen/stats_subscreens/calendar_screen.dart';
import 'package:wego/screens/stats_screen/stats_subscreens/statistics_screen.dart';
import 'package:wego/utils/extensions/string_extension.dart';

import '../../model/menu/nav_model.dart';
import '../../model/menu/subscreen_model.dart';
import '../../utils/internationalization/app_localizations.dart';
import '../../widgets/navigators/side_nav.dart';
import '../../widgets/navigators/tab_nav.dart';
import '../subscren_container.dart';

final  List<SubScreenModel> _statsPages = [

  SubScreenModel(
    page: const CalculationScreen(),
    title: NavModel(
      title: 'nav_calc',
    ),
  ),
  SubScreenModel(
    page: const CalendarScreen(),
    title: NavModel(
      title: 'nav_cal',
    ),
  ),
  SubScreenModel(
      page: const StatisticsScreen(),
      title: NavModel(
        title: 'nav_stats',
      ))
];

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
            Column(
      children: [

        Expanded(
          child: TabNav(
              pages: _statsPages,
          ),
        )
      ],
    );

    //   SubScreenContainer(
    //   pages: _statsPages,
    // );
  }
}

// class StatsScreen extends StatefulWidget {
//   const StatsScreen({super.key});
//
//   @override
//   State<StatsScreen> createState() => _StatsScreenState();
// }
//
// class _StatsScreenState extends State<StatsScreen> {
//
//   late PageController _pageController;
//
//   int _currentPage = 0;
//
//   _onPageChange(int page) {
//     setState(() {
//       _pageController.animateToPage(page,
//           duration: const Duration(microseconds: 500), curve: Curves.easeIn);
//
//       _currentPage = page;
//     });
//   }
//
//
//
//   @override
//   void initState() {
//     _pageController = PageController(initialPage: _currentPage);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//
//     super.dispose();
//     _pageController.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     var iconSize = 5.0;
//     return SafeArea(
//       child: Row(
//         children: [
//           Expanded(
//             child: Center(
//                 key: widget.key,
//                 child: PageView.builder(
//                     physics: const BouncingScrollPhysics(
//                         parent: AlwaysScrollableScrollPhysics()),
//                     itemCount: _pages.length,
//                     controller: _pageController,
//                     onPageChanged: _onPageChange,
//                     itemBuilder: (context, index) {
//                       return _pages
//                           .map((e) => e.page!)
//                           .toList()
//                           .elementAt(index);
//                     })),
//           ),
//           SideNav(
//             // leading: IconButton(
//             //   splashColor: Colors.transparent,
//             //   icon: Icon(
//             //     Icons.settings_outlined,
//             //     size: leadingIconSize,
//             //   ),
//             //   onPressed: () async {
//             //     await Navigator.pushNamed(context, '/settings');
//             //   },
//             // ),
//             iconSize: iconSize,
//             itemCount: _pages.length,
//             titles: _pages.map((e) => e.title!).toList(),
//             selectedItem: _currentPage,
//             onTap: (int sel) {
//               _onPageChange(sel);
//             },
//           ),
//         ],
//       ),
//     );
//
//     //   Column(
//     //   children: [
//     //
//     //     Expanded(
//     //       child: TabNav(
//     //           tabTitles: [
//     //             "Calendar", "Calculations", "Statistics"
//     //           ],
//     //           list:[
//     //             CalendarScreen(),
//     //             CalculationScreen(),
//     //             StatisticsScreen()
//     //
//     //           ]
//     //       ),
//     //     )
//     //   ],
//     // );
//   }
// }
