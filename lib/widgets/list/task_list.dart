import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../../providers/calendar_provider/calendar_provider.dart';
import '../../screens/creator_screen/task_creator.dart';
import '../cards/fit_card.dart';
import '../cards/small_calendar_card.dart';
import '../cards/welcome_card.dart';
import '../headers/empty_list.dart';
import '../headers/info_text.dart';
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
          padding: EdgeInsets.only(top: sidePadding, bottom: sidePadding, left: 0),
          child: Column(
            children: [
              InfoText(
                title: 'You have ${calendarProvider.taskListCounter} task${calendarProvider.taskListCounter > 1 ? 's' : ""}',
                padding: EdgeInsets.only(left: sidePadding, ),
                isInfoIcon: false,
              ),
              Divider(indent: sidePadding, endIndent: sidePadding,),
              Container(
                margin: EdgeInsets.only(left: sidePadding),
                height: MediaQuery.of(context).size.height / 4.5,
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
                                  heroTag: '${data.imagePath}$index${data.title}',
                                  openDetails: (){
                                    Navigator.of(context).push(
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation, secondaryAnimation) => TaskCreator(userModel: data,heroTag: '${data.imagePath}$index${data.title}',),
                                        transitionDuration: Duration(milliseconds: 300),
                                        transitionsBuilder:
                                            (context, animation, secondaryAnimation, child) {
                                          var scale = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                                              parent: animation, curve: Curves.easeIn));
                                          return ScaleTransition(
                                              alignment: Alignment.center, scale: scale, child: child);
                                        },
                                      ),);
                                  }

                                ),
                            ),
                          ),
                        ),
                      );

                    }),
              ),
            ],
          )
        );
      }

    });
  }
}
