import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../../../providers/logic_provider/logic_provider.dart';
import '../../../providers/profile_provider/profile_provider.dart';
import '../../../providers/settings_provider/settings_provider.dart';
import '../../../utils/dimensions/size_info.dart';
import '../../../widgets/cards/fit_card.dart';
import '../../../widgets/chips/chips_list.dart';
import '../../../widgets/headers/info_text.dart';
import '../../../widgets/headers/widget_header.dart';
import 'details_calc_screen.dart';

class CalculationScreen extends StatelessWidget {
  const CalculationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double fontSize = 12.0;
    //double sidePadding = 12.0;
    var edgePadding = SizeInfo.edgePadding;
    return Consumer3<ProfileProvider, LogicProvider, SettingsProvider>(
        builder: (context, profile, logic, settings, child){

      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoText(
            title: 'body_calculations',
            padding: EdgeInsets.only(left: edgePadding, ),
          ),
          const ChoiceChipsList(),
          SizedBox(height: 8.0,),
          // WidgetHeader(
          //   title: "calculations",
          //   fontSize: 15,
          //   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          // ),
          Expanded(
              child:
          GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 18),
          physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics()),
          scrollDirection:Axis.vertical,
          crossAxisSpacing: 0.0,
          shrinkWrap: true,
          mainAxisSpacing: 0.0,
          crossAxisCount: 2,
          childAspectRatio: 2.3 / 3,
          children:
          List.generate( logic.numbersListCounter, (index){
          final listData = logic.mainNumbersList[index];
          return AnimationConfiguration.staggeredGrid(
          columnCount: 2,
          position: index,
          duration: const Duration(milliseconds: 500),
          child: ScaleAnimation(
          scale: 0.9,
          child: FadeInAnimation(
          child: FitCardLarge(
            data: listData,
            heroTag: '${listData.imagePath}${listData.id}$index',
            openDetailPage: (){
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => DetailCalcScreen(
                    data: listData,
                    heroTag: '${listData.imagePath}${listData.id}$index',
                  ),
                  transitionDuration: Duration(milliseconds: 300),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var scale = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: animation, curve: Curves.easeIn));
                    return ScaleTransition(
                        alignment: Alignment.center, scale: scale, child: child);
                  },
                ),);
            },
          )),
          ),
          );
          }
          )),
          ),
        ],
      );
    });
  }
}
