import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../model/chart_model/chart_model.dart';
import '../../model/color/color_switch.dart';
import '../../utils/internationalization/app_localizations.dart';


class ChartCard extends StatefulWidget {
  const ChartCard({required this.chartData, required this.category, super.key});
  final List<ChartModel> chartData;
  final String? category;

  @override
  State<ChartCard> createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  double fontSize = 10.0;

  double findMaxValue(List<ChartModel> data) {
    return data.reduce((currentMax, model) => currentMax.value! > model.value! ? currentMax : model).value!;
  }

  BarChartData prepareChartData(List<ChartModel> data) {
    var cardBcgColor  = ColorSwitch(category: widget.category);
    cardBcgColor.getColor(context);
    double maxValue = findMaxValue(widget.chartData);
    List<BarChartGroupData> bars = data
        .asMap()
        .map((index, model) => MapEntry(
      index,
      BarChartGroupData(
        x: index,
        barsSpace: 15.0,
        barRods: [
          BarChartRodData(
              toY: model.value!,
              color: cardBcgColor.bcgColor,
              borderRadius: BorderRadius.all(Radius.circular(10)), //BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
              width: 20,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: maxValue,
              color: cardBcgColor.bcgColor!.withOpacity(0.3),//Theme.of(context).unselectedWidgetColor.withOpacity(0.5),
            ),
          ),




        ],
      ),
    )).values.toList();

    return BarChartData(
      barGroups: bars,
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),

        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double value, TitleMeta meta) {
              return SideTitleWidget(
                axisSide: meta.axisSide,
                space: 5.0,
                child: Text('${AppLocalizations.of(context)!.dateFormat(data[value.toInt()].dateTime!,context).shortDate}'
                    ,style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize)),
              );
            },
          ),
        ),

      ),
      borderData: FlBorderData(
        show: false,
      ),
      gridData: const FlGridData(show: false),

      barTouchData: BarTouchData(
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {

            }
            //   touchedIndex = -1;
            //   return;
            // }
            // touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: cardBcgColor.patternColor,
          fitInsideVertically: true,
          getTooltipItem: (group, groupIndex, rod, rodIndex){
            return BarTooltipItem(
              '${AppLocalizations.of(context)!.dateFormat(data[rodIndex].dateTime!,context).fullDate}\n',
                Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 10.0),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                ),
                TextSpan(
                  text: ' ${data[rodIndex].unit}',
                ),
              ],
            );
          },

        )
      ),
    );
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BarChartData data = prepareChartData(widget.chartData);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: widget.chartData.length * 45,
        child: BarChart(
                data
        ),
      ),
    );
  }
}
