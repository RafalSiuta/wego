import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wego/model/chart_model/chart_model.dart';
import 'package:wego/providers/calendar_provider/calendar_provider.dart';
import 'package:wego/providers/logic_provider/logic_provider.dart';
import 'package:wego/providers/profile_provider/profile_provider.dart';
import 'package:wego/widgets/cards/fit_card.dart';

import '../../../data/dummy_chart_data.dart';
import '../../../model/color/color_switch.dart';
import '../../../utils/dimensions/size_info.dart';
import '../../../utils/internationalization/app_localizations.dart';
import '../../../widgets/chart/chart_card.dart';
import '../../../widgets/chips/chips_list.dart';
import '../../../widgets/containers/chart_blur_box.dart';
import '../../../widgets/headers/info_text.dart';
import '../../../widgets/responsive/list_builder.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var edgePadding = SizeInfo.edgePadding;
    var choiceChipsHeight = 40.0;
    return Consumer3<LogicProvider,CalendarProvider,ProfileProvider>(
      builder:(context, logic, calendar,profile, child){
        return
        ListView(
          children: [
            Column(
              children: [
                InfoText(
                  title: 'calendar_history',
                  padding: EdgeInsets.only(left: edgePadding, ),
                ),
                Container(
                  margin: EdgeInsets.only(left: edgePadding),
                  height: choiceChipsHeight,
                  child: ListBuilder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: false,
                      itemCount: calendar.categoryChartList.length,
                      itemBuilder: (context, index){
                        var calendarList = calendar.categoryChartList[index];
                        return FitCardMini(
                            title: AppLocalizations.of(context)!.translate(calendarList.name!),
                            category: calendarList.category,
                            onTap: (newVal){
                              calendar.calendarChipChoice(index, newVal);
                            }, value:calendarList.value);
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),

                ChartBlurBox(
                  marginValue: edgePadding,
                  topPadding: 10.0,
                  bottomPadding: 5.0,
                  borderRadiusAll: 15.0,
                  child: ChartCard(
                    category: calendar.selectedChartCategory,
                    chartData: calendar.selectedChartList,
                  ),
                )
              ],
            ),
            Column(
              children: [
                InfoText(
                  title: 'calculation_history',
                  padding: EdgeInsets.only(left: edgePadding, ),
                ),
                Container(
                  margin: EdgeInsets.only(left: edgePadding),
                  height: choiceChipsHeight,
                  child: ListBuilder(
                      scrollDirection: Axis.horizontal,
                      itemCount: logic.numbersListCounter,
                      itemBuilder: (context, index){
                        var calculationList = logic.mainNumbersList[index];
                        return FitCardMini(
                            title: calculationList.shortTitle!,
                            iconData: calculationList.symbol!,
                            category: calculationList.category!,
                            onTap: (newVal){

                              logic.calculationsChipChoice(index, newVal);
                            }, value: calculationList.isActiveChips);
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                ChartBlurBox(
                  marginValue: edgePadding,
                  topPadding: 10.0,
                  bottomPadding: 5.0,
                  borderRadiusAll: 15.0,
                  child: ChartCard(
                    category: logic.selectedChartCategory,
                    chartData: logic.selectedChart
                  ),
                )
              ],
            ),
            Column(
              children: [
                InfoText(
                  title: 'body_history',
                  padding: EdgeInsets.only(left: edgePadding, ),
                ),
                Container(
                  margin: EdgeInsets.only(left: edgePadding),
                  height: choiceChipsHeight,
                  child: ListBuilder(
                      scrollDirection: Axis.horizontal,
                      itemCount: profile.chipBodyList.length,
                      itemBuilder: (context, index){
                        var bodyDataList = profile.chipBodyList[index];
                        return FitCardMini(
                            title: AppLocalizations.of(context)!.translate(bodyDataList.name!),

                            category: '',
                            onTap: (newVal){
                              profile.userChipChoice(index, newVal);
                            }, value: index == profile.selectedChip);
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                ChartBlurBox(
                  marginValue: edgePadding,
                  topPadding: 10.0,
                  bottomPadding: 5.0,
                  borderRadiusAll: 15.0,
                  child: ChartCard(
                    category: '',
                    chartData: profile.profileSavesList,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            )
          ],
        );
          // SingleChildScrollView(
          //   //scrollDirection: A,
          //   child: Column(
          //     children: [
          //
          //     ],
          //   ),
          // );
      }
    );
  }
}
