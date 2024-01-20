import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../providers/calendar_provider/calendar_provider.dart';
import '../cards/fit_card.dart';
import '../cards/small_calendar_card.dart';
import '../cards/welcome_card.dart';
import '../headers/empty_list.dart';
import '../headers/widget_header.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    var columnCount = 2;
    double sidePadding  = 12.0;

    return Consumer<CalendarProvider>(builder: (context, calendarProvider, child){
      if (calendarProvider.taskList.isEmpty) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: const EmptyListDisplay(
            title: 'There is no assign task for today',
          ),
        );
      }else {
        return Padding(
          padding: EdgeInsets.all(sidePadding),
          child: Column(
            children: [
              WidgetHeader(
                title: 'You have ${calendarProvider.taskListCounter} task${calendarProvider.taskListCounter > 1 ? 's' : ""}',
                fontSize: 18,
                padding: EdgeInsets.symmetric(vertical: .0, horizontal: sidePadding),
              ),
              Divider(indent: sidePadding, endIndent: sidePadding,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: sidePadding),
                height: MediaQuery.of(context).size.height / 5,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: calendarProvider.taskListCounter,
                    itemBuilder: (context,index){
                      final data = calendarProvider.taskList[index];
                      return AnimationLimiter(
                        child: AnimationConfiguration.staggeredList(
                          position: index,
                          child: ScaleAnimation(
                            scale: 0.5,
                            child: FadeInAnimation(
                                child:
                                SmallCalendarCard(
                                  title: '${data.title}',
                                  subtitle: data.subtitle,
                                  value: data.progressValue,
                                  imagePath: data.imagePath,
                                  category: data.category,

                                ),
                                // AspectRatio(
                                //   aspectRatio: 1,
                                //   child: Card(
                                //     child: Center(
                                //       child: Text('${data.title}'),
                                //     ),
                                //     //todo direct to creator page
                                //     // await Navigator.push(
                                //     // context,
                                //     // CustomPageRoute(
                                //     //     child: NoteCreator(
                                //     //       newNote: list,
                                //     //       editEnable: false,
                                //     //     ),
                                //     //     direction: AxisDirection.up));
                                //   ),
                                // )
                            ),
                          ),
                        ),
                      );

                    }),
              ),
              // AnimationLimiter(
              //   child: GridView.count(
              //       physics: const BouncingScrollPhysics(
              //           parent: AlwaysScrollableScrollPhysics()),
              //       scrollDirection:Axis.vertical,
              //       crossAxisSpacing: 0.0,
              //       shrinkWrap: true,
              //       mainAxisSpacing: 0.0,
              //       crossAxisCount: columnCount,
              //       childAspectRatio: 2.3 / 3,
              //       children: List.generate(calendarProvider.taskListCounter, (index) {
              //         final tasks = calendarProvider.taskList[index];
              //         return AnimationConfiguration.staggeredGrid(
              //           columnCount: columnCount,
              //           position: index,
              //           duration: const Duration(milliseconds: 375),
              //           child: ScaleAnimation(
              //             scale: 0.5,
              //             child: FadeInAnimation(
              //                 child: Card(
              //                   child: Center(
              //                     child: Text('${tasks.title}'),
              //                   ),
              //                   //todo direct to creator page
              //                   // await Navigator.push(
              //                   // context,
              //                   // CustomPageRoute(
              //                   //     child: NoteCreator(
              //                   //       newNote: list,
              //                   //       editEnable: false,
              //                   //     ),
              //                   //     direction: AxisDirection.up));
              //                 )
              //             ),
              //           ),
              //         );
              //       })),
              // ),
            ],
          )
        );
      }

    });
  }
}
