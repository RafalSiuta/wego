import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/color/color_switch.dart';
import '../../providers/logic_provider/logic_provider.dart';
import '../responsive/column_row_builder.dart';
import '../responsive/list_builder.dart';

class ChoiceChipsList extends StatelessWidget {
  const ChoiceChipsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LogicProvider>(
        builder: (context, logic, child){
          return Container(
            height: 30,
            padding: const EdgeInsets.only(left: 12.0, ),
            child: ListBuilder(
              //mainAxisAlignment: MainAxisAlignment.start,
              scrollDirection: Axis.horizontal,
              itemCount: logic.choiceChipList.length,
              itemBuilder: (context, index){
                final chipData = logic.choiceChipList[index];
                var cardBcgColor  = ColorSwitch(category: chipData.category);
                cardBcgColor.getColor(context);
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    // avatar: Text(
                    //   'test',
                    //   style: Theme.of(context).textTheme.headlineMedium!.copyWith( fontSize: fontSize),
                    // ),
                    selectedColor: cardBcgColor.bcgColor,
                    disabledColor: Theme.of(context).unselectedWidgetColor,
                    showCheckmark: false,//index == 1 ? false : true,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                    elevation: 0,
                    label: Text(
                      "${chipData.name}",
                      textAlign:  TextAlign.center,
                      style: chipData.value! ? Theme.of(context).textTheme.headlineMedium!.copyWith( fontSize: 10, ):Theme.of(context).textTheme.displaySmall!.copyWith( fontSize: 10, ) ,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Theme.of(context).unselectedWidgetColor),
                    ),
                    selected: chipData.value!,
                    onSelected: (bool newValue) {
                      logic.chipChoice(index, newValue);
                    },
                  ),
                );

              }, ),
          );

    });
  }
}
