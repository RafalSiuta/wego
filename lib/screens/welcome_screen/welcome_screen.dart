
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:wego/widgets/cards/fit_card.dart';
import 'package:wego/widgets/headers/date_header.dart';
import 'package:flutter/material.dart';
import 'package:wego/widgets/responsive/column_row_builder.dart';

import '../../model/color/color_switch.dart';
import '../../providers/logic_provider/logic_provider.dart';
import '../../providers/welcome_provider/welcome_provider.dart';
import '../../widgets/cards/welcome_card.dart';
import '../../widgets/carousel/indicators.dart';
import '../../widgets/chips/chips_list.dart';
import '../../widgets/headers/info_text.dart';
import '../../widgets/headers/widget_header.dart';
import '../../widgets/responsive/list_builder.dart';
import '../creator_screen/task_creator.dart';
import '../stats_screen/stats_subscreens/details_calc_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {


  @override
  Widget build(BuildContext context) {
    double fontSize = 12.0;
    bool choiceValue = true;
    return  Consumer2<LogicProvider,WelcomeProvider>(
      builder: (context, logic, welcomeProvider, child){
        return
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    const DateHeader(),
                    Container(
                      margin: EdgeInsets.only(top: 53),
                      child: CarouselSlider.builder(
                        itemCount: welcomeProvider.calendarProvider.taskListCounter,
                        carouselController: welcomeProvider.carouselController,
                        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                          var data = welcomeProvider.calendarProvider.taskList[itemIndex];
                          return WelcomeCard(
                              title: data.title,
                              subtitle: '${4} ${data.subtitle}:',
                              value: data.progressValue,
                              imagePath: data.imagePath,
                              category: data.category,
                              heroTag: '${data.imagePath}$itemIndex',
                              onTap:(){
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => TaskCreator(userModel: data, heroTag: '${data.imagePath}$itemIndex',),
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
                          );
                        },
                        options: CarouselOptions(
                            height: MediaQuery.of(context).size.height,
                            aspectRatio: 2/5,
                            viewportFraction: 0.7,
                            initialPage: welcomeProvider.currentPage,
                            enableInfiniteScroll: false,
                            reverse: false,
                            autoPlay: false,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, fun){
                              welcomeProvider.onCarouselChange(index);
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.arrow_left),
                      onPressed: welcomeProvider.goToPrevious
                  ),
                  SliderIndicators(
                    items: welcomeProvider.calendarProvider.taskList,
                    itemCount: welcomeProvider.calendarProvider.taskListCounter,
                    mapIndicators: (i, url) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: .0),
                        child: Icon(
                          Icons.circle,
                          size: 6.0,
                          color: welcomeProvider.currentPage == i
                              ? Theme.of(context).indicatorColor
                              : Theme.of(context).unselectedWidgetColor,
                        ),
                      );
                    },
                  ),
                  IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.arrow_right),
                      onPressed: welcomeProvider.goToNext
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoText(
                    title: 'body_calculations',
                    padding: EdgeInsets.only(left: 12.0, ),
                    isInfoIcon: false,
                  ),
                  //const ChoiceChipsList(),
                  Divider(indent: fontSize, endIndent: fontSize,),
                  //todo add categories to sort list items
                  Container(
                    margin: EdgeInsets.all(8.0),

                    height: MediaQuery.of(context).size.height / 5.2,
                    child: ListBuilder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                        itemCount: logic.numbersListCounter,
                        // physics: const BouncingScrollPhysics(
                        //     parent: AlwaysScrollableScrollPhysics()),
                        itemBuilder: (context,index){
                      final listData = logic.mainNumbersList[index];
                      return FitCardSmall(
                        data: listData,
                        heroTag: '${listData.imagePath}$index',
                        onTap: (){
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => DetailCalcScreen(
                                  data: listData,
                                  heroTag: '${listData.imagePath}$index',
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
                      );
                    },
                    //   separatorBuilder: (context, index){
                    //     return SizedBox(width: 1,);
                    // }
                    ),
                  ),
                ],
              )


            ],
          );
      },
    );


  }
}
